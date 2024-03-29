/*
 This file defines the permissions of the writer role for the database.
*/

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

## Grant all privileges all current and future schemas
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
