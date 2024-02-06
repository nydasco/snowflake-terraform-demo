/*
 This Terraform code creates team roles and app roles in Snowflake, and grants access to users and apps respectively.
 Users are defined as both people and service accounts.
 Roles and the users with access to those roles is defined at the top. Terraform will iterate through this and build out 
 the required structures.
 Note the use of the snowflake.security_admin provider to elevate permissions when this code is run.

 For this demonstration, we are creating a team role for data engineers and app roles for each dbt service accounts.
*/

locals {
    team_roles = {
        "USR_ROLE_DATA_ENGINEER" = {
            comment = "Data Engineers should be assigned this role"
            granted_to_users = [
                "USR_LASTNAME_FIRSTNAME",
                "USR_LASTNAME_FIRSTNAME_1",
            ]
        }
    }
    app_roles = {
        "SVC_ROLE_DBT_DEV" = {
            comment = "Some service account should be assigned this role"
            granted_to_users = [
                "APP_USR_DBT_DEV",
            ]
        }
        "SVC_ROLE_DBT_STG" = {
            comment = "Some service account should be assigned this role"
            granted_to_users = [
                "APP_USR_DBT_STG",
            ]
        }
        "SVC_ROLE_DBT_PRD" = {
            comment = "Some service account should be assigned this role"
            granted_to_users = [
                "APP_USR_DBT_PRD",
            ]
        }
    }
}

### CREATE THE TEAM ROLES ###

# This resource block creates team roles in Snowflake.
# Each team role is defined in the `team_roles` local variable.
# The `name` attribute specifies the name of the role.
# The `comment` attribute provides a description of the role.

resource "snowflake_role" "team_role" {
    provider = snowflake.security_admin
    for_each = local.team_roles
    name = each.key
    comment = each.value.comment
}

### GRANT ACCESS TO USERS ###

# This resource block grants access to users for the team roles created above.
# Each team role is defined in the `team_roles` local variable.
# The `role_name` attribute specifies the name of the role to grant access to.
# The `roles` attribute specifies the roles to grant to the users.
# The `users` attribute specifies the users to grant access to.

resource "snowflake_role_grants" "team_roles_to_users" {
    provider = snowflake.security_admin
    for_each = local.team_roles
    role_name = each.key
    roles     = ["SECURITYADMIN"]
    users = each.value.granted_to_users
    depends_on = [ snowflake_user.users_sso ]
}


### CREATE THE APP ROLES ###

# This resource block creates app roles in Snowflake.
# Each app role is defined in the `app_roles` local variable.
# The `name` attribute specifies the name of the role.
# The `comment` attribute provides a description of the role.

resource "snowflake_role" "app_role" {
    provider = snowflake.security_admin
    for_each = local.app_roles
    name = each.key
    comment = each.value.comment
}

### GRANT ACCESS TO APPS ###

# This resource block grants access to apps for the app roles created above.
# Each app role is defined in the `app_roles` local variable.
# The `role_name` attribute specifies the name of the role to grant access to.
# The `roles` attribute specifies the roles to grant to the apps.
# The `users` attribute specifies the apps to grant access to.

resource "snowflake_role_grants" "app_roles_to_apps" {
    provider = snowflake.security_admin
    for_each = local.app_roles
    role_name = each.key
    roles     = ["SECURITYADMIN"]
    users = each.value.granted_to_users
    depends_on = [ snowflake_user.app_key_pair ]
}