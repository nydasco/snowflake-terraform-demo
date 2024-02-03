### SERVICE ACCOUNTS SHOULD BE MANAGED HERE ###
# I've assumed that service accounts would use public/private key pairs.
# Accounts can be managed in the locals block, and then the Terraform resource will iterate through them.

locals {
    app_key_pair = {
        "APP_USR_DBT" = {
            display_name = "DBT SERVICE ACCOUNT"
            login_name = "svc_dbt@domain.com"
            rsa_public_key = "MIIBIjjNBA..."
            disabled = false
        }
    }
}

resource "snowflake_user" "app_key_pair" {
    provider = snowflake.security_admin
    for_each = local.app_key_pair
    name = each.key
    display_name = each.value.display_name
    login_name = each.value.login_name
    rsa_public_key = each.value.rsa_public_key
    disabled = each.value.disabled
}