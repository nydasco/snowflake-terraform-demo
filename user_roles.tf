### CREATING ROLES FOR USERS ###
# Users are defined as both people and service accounts.
# Roles and the users with access to those roles is defined at the top.
# Terraform will iterate through this and build out the required structures.
# Note the use of the snowflake.security_admin provider to elevate permissions
# when this code is run.

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
resource "snowflake_role" "team_role" {
    provider = snowflake.security_admin
    for_each = local.team_roles
    name = each.key
    comment = each.value.comment
}

### GRANT ACCESS TO USERS ###
resource "snowflake_role_grants" "team_roles_to_users" {
    provider = snowflake.security_admin
    for_each = local.team_roles
    role_name = each.key
    roles     = ["SECURITYADMIN"]
    users = each.value.granted_to_users
    depends_on = [ snowflake_user.users_sso ]
}


### CREATE THE APP ROLES ###
resource "snowflake_role" "app_role" {
    provider = snowflake.security_admin
    for_each = local.app_roles
    name = each.key
    comment = each.value.comment
}

### GRANT ACCESS TO APPS ###
resource "snowflake_role_grants" "app_roles_to_apps" {
    provider = snowflake.security_admin
    for_each = local.app_roles
    role_name = each.key
    roles     = ["SECURITYADMIN"]
    users = each.value.granted_to_users
    depends_on = [ snowflake_user.app_key_pair ]
}