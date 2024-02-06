/*
    This Terraform code defines a local variable called "app_key_pair" which is a map of application service accounts.
    Each account consists of a unique identifier and a set of attributes including display name, login name, RSA public key, 
    and disabled status.

    The code also creates a Snowflake user resource using the "snowflake_user" provider. It iterates over the "app_key_pair"
    map using the "for_each" argument, creating a Snowflake user for each key pair. The Snowflake user is configured with 
    the provided attributes such as name, display name, login name, RSA public key, and disabled status.

    Three application service accounts are provided to get started - a dbt service account for each environment (DEV, STG, PRD).

		Note that the rsa_public_key lines have been commented out. Terraform will fail if the keys are invalid. Running this 'as is'
		will build, but the service accounts won't have key/pair or password authentication. You won't be able to use them.
*/
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