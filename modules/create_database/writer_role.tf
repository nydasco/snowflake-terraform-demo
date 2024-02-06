### A FILE LIKE THIS WILL EXIST FOR EACH ROLE THAT IS DEFINED IN THE ROLES.TF FILE ###
# The purpose of this file is to set the access permissions for each of the roles defined
# for the database.

## Access Database
resource "snowflake_grant_privileges_to_account_role" "database__writer__database_usage" {
    provider = snowflake.security_admin
    privileges = ["USAGE"]
    account_role_name  = snowflake_role.database__writer.name
    on_account_object {
      object_type = "DATABASE"
      object_name = snowflake_database.database.name
    }
}

## Access all current and future schemas
resource "snowflake_grant_privileges_to_account_role" "database__writer__all_schema_usage" {
    provider = snowflake.security_admin
    privileges = ["USAGE"]
    account_role_name  = snowflake_role.database__writer.name
    on_schema {
      all_schemas_in_database = snowflake_database.database.name
    }
}

resource "snowflake_grant_privileges_to_account_role" "database__writer__future_schema_usage" {
    provider = snowflake.security_admin
    privileges = ["USAGE"]
    account_role_name  = snowflake_role.database__writer.name
    on_schema {
      future_schemas_in_database = snowflake_database.database.name
    }
}

## Access all current and future tables and views
resource "snowflake_grant_privileges_to_account_role" "database__writer__all_privileges" {
    provider = snowflake.security_admin
    account_role_name  = snowflake_role.database__writer.name
    on_schema {
      all_schemas_in_database = snowflake_database.database.name
    }
    all_privileges = true
}

resource "snowflake_grant_privileges_to_account_role" "database__writer__future_privileges" {
    provider = snowflake.security_admin
    account_role_name  = snowflake_role.database__writer.name
    on_schema {
      future_schemas_in_database = snowflake_database.database.name
    }
    all_privileges = true
}
