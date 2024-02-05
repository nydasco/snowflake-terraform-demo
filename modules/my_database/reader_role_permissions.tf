### A FILE LIKE THIS WILL EXIST FOR EACH ROLE THAT IS DEFINED IN THE ROLES.TF FILE ###
# The purpose of this file is to set the access permissions for each of the roles defined
# for the database.

## Access Database
resource "snowflake_grant_privileges_to_role" "database__reader__database_usage" {
    provider = snowflake.security_admin
    privileges = ["USAGE"]
    role_name  = snowflake_role.database__reader.name
    on_account_object {
      object_type = "DATABASE"
      object_name = snowflake_database.database.name
    }
}

## Access all current and future schemas
resource "snowflake_grant_privileges_to_role" "database__reader__all_schema_usage" {
    provider = snowflake.security_admin
    privileges = ["USAGE"]
    role_name  = snowflake_role.database__reader.name
    on_schema {
      all_schemas_in_database = snowflake_database.database.name
    }
}

resource "snowflake_grant_privileges_to_role" "database__reader__future_schema_usage" {
    provider = snowflake.security_admin
    privileges = ["USAGE"]
    role_name  = snowflake_role.database__reader.name
    on_schema {
      future_schemas_in_database = snowflake_database.database.name
    }
}

## Access all current and future tables and views
resource "snowflake_grant_privileges_to_role" "database__reader__select_all_tables" {
    provider = snowflake.security_admin
    privileges = ["SELECT"]
    role_name  = snowflake_role.database__reader.name
    on_schema_object {
      all {
        object_type_plural = "TABLES"
        in_database = snowflake_database.database.name
      }
    }
}

resource "snowflake_grant_privileges_to_role" "database__reader__select_future_tables" {
    provider = snowflake.security_admin
    privileges = ["SELECT"]
    role_name  = snowflake_role.database__reader.name
    on_schema_object {
      future {
        object_type_plural = "TABLES"
        in_database = snowflake_database.database.name
      }
    }
}

resource "snowflake_grant_privileges_to_role" "database__reader__select_all_views" {
    provider = snowflake.security_admin
    privileges = ["SELECT"]
    role_name  = snowflake_role.database__reader.name
    on_schema_object {
      all {
        object_type_plural = "VIEWS"
        in_database = snowflake_database.database.name
      }
    }
}

resource "snowflake_grant_privileges_to_role" "database__reader__select_future_views" {
    provider = snowflake.security_admin
    privileges = ["SELECT"]
    role_name  = snowflake_role.database__reader.name
    on_schema_object {
      future {
        object_type_plural = "VIEWS"
        in_database = snowflake_database.database.name
      }
    }
}