### USER MANAGEMENT ###
# Use this to create users within Snowflake. No permissions have been assigned
# and the assumption is that the users will log in using SSO. For login with 
# key pair, see apps.tf. For access with password, simply add a 'password = xyz'
# section to each user, and a 'password = each.value.password' to the resource.
# If using passwords, it would be best practice to also ensure the option to change
# password on first login was set. Remember, putting passwords in here isn't great! 

locals {
    users_sso = {
        "USR_LASTNAME_FIRSTNAME" = {
            display_name = "FIRSTNAME LASTNAME"
            first_name = "Firstname"
            last_name = "Lastname"
            email = "name@domain.com"
            login_name = "name@domain.com"
            disabled = false
        },
        "USR_LASTNAME_FIRSTNAME_1" = {
            display_name = "FIRSTNAME LASTNAME"
            first_name = "Firstname"
            last_name = "Lastname"
            email = "name_1@domain.com"
            login_name = "name_1@domain.com"
            disabled = false
        }
    }
}

resource "snowflake_user" "user_sso" {
    provider = snowflake.security_admin
    for_each = local.users_sso
    name = each.key
    display_name = each.value.display_name
    first_name = each.value.first_name
    last_name = each.value.last_name
    email = each.value.email
    login_name = each.value.login_name
    disabled = each.value.disabled
}