### SERVICE ACCOUNTS SHOULD BE MANAGED HERE ###
# I've assumed that service accounts would use public/private key pairs.
# Accounts can be managed in the locals block, and then the Terraform resource will iterate through them.

locals {
    app_key_pair = {
        "APP_USR_DBT_DEV" = {
            display_name = "DBT DEV SERVICE ACCOUNT"
            login_name = "svc_dbt_dev@domain.com"
            #rsa_public_key = "MIIBIjjNBA..."
            disabled = false
        }
        "APP_USR_DBT_STG" = {
            display_name = "DBT STG SERVICE ACCOUNT"
            login_name = "svc_dbt_stg@domain.com"
            #rsa_public_key = "MIIBIjjNBA..."
            disabled = false
        }
        "APP_USR_DBT_PRD" = {
            display_name = "DBT PRD SERVICE ACCOUNT"
            login_name = "svc_dbt_prd@domain.com"
            #rsa_public_key = "MIIBIjjNBA..."
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
    #rsa_public_key = each.value.rsa_public_key
    disabled = each.value.disabled
}