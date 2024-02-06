/*
 This file defines the permissions of the reader role for the database.
*/

## Access Database
resource "snowflake_grant_privileges_to_account_role" "database__reader__database_usage" {
    provider = snowflake.security_admin
    privileges = ["USAGE"]
    account_role_name  = snowflake_role.database__reader.name
    on_account_object {
      object_type = "DATABASE"
      object_name = snowflake_database.database.name
    }
}

## Access all current and future schemas
resource "snowflake_grant_privileges_to_account_role" "database__reader__all_schema_usage" {
    provider = snowflake.security_admin
    privileges = ["USAGE"]
    account_role_name  = snowflake_role.database__reader.name
    on_schema {
      all_schemas_in_database = snowflake_database.database.name
    }
}

resource "snowflake_grant_privileges_to_account_role" "database__reader__future_schema_usage" {
    provider = snowflake.security_admin
    privileges = ["USAGE"]
    account_role_name  = snowflake_role.database__reader.name
    on_schema {
      future_schemas_in_database = snowflake_database.database.name
    }
}

## Access all current and future tables and views
resource "snowflake_grant_privileges_to_account_role" "database__reader__select_all_tables" {
    provider = snowflake.security_admin
    privileges = ["SELECT"]
    account_role_name  = snowflake_role.database__reader.name
    on_schema_object {
      all {
        object_type_plural = "TABLES"
        in_database = snowflake_database.database.name
      }
    }
}

resource "snowflake_grant_privileges_to_account_role" "database__reader__select_future_tables" {
    provider = snowflake.security_admin
    privileges = ["SELECT"]
    account_role_name  = snowflake_role.database__reader.name
    on_schema_object {
      future {
        object_type_plural = "TABLES"
        in_database = snowflake_database.database.name
      }
    }
}

resource "snowflake_grant_privileges_to_account_role" "database__reader__select_all_views" {
    provider = snowflake.security_admin
    privileges = ["SELECT"]
    account_role_name  = snowflake_role.database__reader.name
    on_schema_object {
      all {
        object_type_plural = "VIEWS"
        in_database = snowflake_database.database.name
      }
    }
}

resource "snowflake_grant_privileges_to_account_role" "database__reader__select_future_views" {
    provider = snowflake.security_admin
    privileges = ["SELECT"]
    account_role_name  = snowflake_role.database__reader.name
    on_schema_object {
      future {
        object_type_plural = "VIEWS"
        in_database = snowflake_database.database.name
      }
    }
}