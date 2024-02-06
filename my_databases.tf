/*
 This Terraform file leverages the `create_database` module to create three databases: DEV, STG, and PRD.
 As part of this, we define the database names, and also the schemas that should be created within each database.

 We then define the roles that should have access to each database, and have provided Data Engineers with read access
 and the service accounts with both read and write access. While the engineers have access to all environments, the 
 service accounts only have access to their respective databases.
*/

# create the database
module "my_database_dev" {
  source = "./modules/create_database"
  db_name = "my_database_dev"
  schema_name = {
    "RAW" = "contains raw data from our source systems"
    "PRESENTATION" = "contains tables and views accessible to analysts and reporting"
  }
}

# which teams can use it?
resource "snowflake_role_grants" "my_database_dev__reader" {
    provider = snowflake.security_admin
    role_name = module.my_database_dev.reader
    roles = [
        # Team Roles
        snowflake_role.team_role["USR_ROLE_DATA_ENGINEER"].id,
        # App Roles
        snowflake_role.app_role["SVC_ROLE_DBT_DEV"].id,
        "SECURITYADMIN"
    ]
}

resource "snowflake_role_grants" "my_database_dev__writer" {
    provider = snowflake.security_admin
    role_name = module.my_database_dev.writer
    roles = [
        # App Roles
        snowflake_role.app_role["SVC_ROLE_DBT_DEV"].id,
        "SECURITYADMIN"
    ]
}

### STAGING ###

module "my_database_stg" {
  source = "./modules/create_database"
  db_name = "my_database_stg"
  schema_name = {
    "RAW" = "contains raw data from our source systems"
    "PRESENTATION" = "contains tables and views accessible to analysts and reporting"
  }
}

# which teams can use it?
resource "snowflake_role_grants" "my_database_stg__reader" {
    provider = snowflake.security_admin
    role_name = module.my_database_stg.reader
    roles = [
        # Team Roles
        snowflake_role.team_role["USR_ROLE_DATA_ENGINEER"].id,
        # App Roles
        snowflake_role.app_role["SVC_ROLE_DBT_STG"].id,
        "SECURITYADMIN"
    ]
}

resource "snowflake_role_grants" "my_database_stg__writer" {
    provider = snowflake.security_admin
    role_name = module.my_database_stg.writer
    roles = [
        # App Roles
        snowflake_role.app_role["SVC_ROLE_DBT_STG"].id,
        "SECURITYADMIN"
    ]
}

### PRODUCTION ###

module "my_database_prd" {
  source = "./modules/create_database"
  db_name = "my_database_prd"
  schema_name = {
    "RAW" = "contains raw data from our source systems"
    "PRESENTATION" = "contains tables and views accessible to analysts and reporting"
  }
}

# which teams can use it?
resource "snowflake_role_grants" "my_database_prd__reader" {
    provider = snowflake.security_admin
    role_name = module.my_database_prd.reader
    roles = [
        # Team Roles
        snowflake_role.team_role["USR_ROLE_DATA_ENGINEER"].id,
        # App Roles
        snowflake_role.app_role["SVC_ROLE_DBT_PRD"].id,
        "SECURITYADMIN"
    ]
}

resource "snowflake_role_grants" "my_database_prd__writer" {
    provider = snowflake.security_admin
    role_name = module.my_database_prd.writer
    roles = [
        # App Roles
        snowflake_role.app_role["SVC_ROLE_DBT_PRD"].id,
        "SECURITYADMIN"
    ]
}