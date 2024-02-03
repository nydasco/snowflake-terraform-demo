### AN EXAMPLE DATABASE CREATION AND ROLE ASSIGNMENT ###
# The database should first be framed out at the top, with each schema listed.
# We then define the roles and permissions related to this database, and assign
# those roles to user roles.

### CREATE THE DATABASE AND SCHEMAS ###

locals {
  database_name_prd__schemas = {
    "RAW" = {
      database = "DATABASE_NAME_PRD"
      comment = "contains raw data from our source systems"
    }
    "PRESENTATION" = {
      database = "DATABASE_NAME_PRD"
      comment = "contains tables and views accessible to analysts and reporting"
    }
  }
}

resource "snowflake_database" "database_name_prd" {
  name = "DATABASE_NAME_PRD"
  comment = "Example database creation"
}

resource "snowflake_schema" "database_name_prd__schema" {
  for_each = local.database_name_prd__schemas
  name     = each.key
  database = each.value.database
  comment  = each.value.comment
  depends_on = [
    snowflake_database.database_name_prd
  ]
}

### DEFINE THE ROLES WITH DIRECT ACCESS TO THE DATABASE ###

### WHAT IS IT CALLED? ###
resource "snowflake_role" "database_name_prd__reader" {
    provider = snowflake.security_admin
    name = "DATABASE_NAME_PRD__READER"
    comment = "This role has full access to read the DATABASE_NAME database incl. all schemas."
}

### WHICH TEAMS CAN USE IT? ###
resource "snowflake_role_grants" "database_name_prd__reader" {
    provider = snowflake.security_admin
    role_name = snowflake_role.database_name_prd__reader.name
    roles     = [
        "USR_ROLE_DATA_ENGINEER",
    ]
    depends_on = [ 
        snowflake_role.team_role,
        snowflake_role.app_role
        ]
}

### WHAT CAN IT DO? ###

## Access Database
resource "snowflake_grant_privileges_to_role" "database_name_prd__reader__database_usage" {
    provider = snowflake.security_admin
    privileges = ["USAGE"]
    role_name  = snowflake_role.database_name_prd__reader.name
    on_account_object {
      object_type = "DATABASE"
      object_name = snowflake_database.database_name_prd.name
    }
}

## Access all current and future schemas
resource "snowflake_grant_privileges_to_role" "database_name_prd__reader__all_schema_usage" {
    provider = snowflake.security_admin
    privileges = ["USAGE"]
    role_name  = snowflake_role.database_name_prd__reader.name
    on_schema {
      all_schemas_in_database = snowflake_database.database_name_prd.name
    }
}

resource "snowflake_grant_privileges_to_role" "database_name_prd__reader__future_schema_usage" {
    provider = snowflake.security_admin
    privileges = ["USAGE"]
    role_name  = snowflake_role.database_name_prd__reader.name
    on_schema {
      future_schemas_in_database = snowflake_database.database_name_prd.name
    }
}

## Access all current and future tables and views
resource "snowflake_grant_privileges_to_role" "database_name_prd__reader__select_all_tables" {
    provider = snowflake.security_admin
    privileges = ["SELECT"]
    role_name  = snowflake_role.database_name_prd__reader.name
    on_schema_object {
      all {
        object_type_plural = "TABLES"
        in_database = snowflake_database.database_name_prd.name
      }
    }
}

resource "snowflake_grant_privileges_to_role" "database_name_prd__reader__select_future_tables" {
    provider = snowflake.security_admin
    privileges = ["SELECT"]
    role_name  = snowflake_role.database_name_prd__reader.name
    on_schema_object {
      future {
        object_type_plural = "TABLES"
        in_database = snowflake_database.database_name_prd.name
      }
    }
}

resource "snowflake_grant_privileges_to_role" "database_name_prd__reader__select_all_views" {
    provider = snowflake.security_admin
    privileges = ["SELECT"]
    role_name  = snowflake_role.database_name_prd__reader.name
    on_schema_object {
      all {
        object_type_plural = "VIEWS"
        in_database = snowflake_database.database_name_prd.name
      }
    }
}

resource "snowflake_grant_privileges_to_role" "database_name_prd__reader__select_future_views" {
    provider = snowflake.security_admin
    privileges = ["SELECT"]
    role_name  = snowflake_role.database_name_prd__reader.name
    on_schema_object {
      future {
        object_type_plural = "VIEWS"
        in_database = snowflake_database.database_name_prd.name
      }
    }
}