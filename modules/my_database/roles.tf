### HERE WE CREATE THE ACCESS ROLES, AND WHICH TEAM ROLE CAN ACCESS THOSE ROLES ###
# Importantly each resource must be uniquely named, so we have prefixed the
# role - reader - with the name of the database (passed from the environment variable) 
# to ensure uniqueness. If you were securing at the schema level, you would need to 
# prefix with the database name and schema name.

### WHAT IS IT CALLED? ###
resource "snowflake_role" "database__reader" {
    provider = snowflake.security_admin
    name = upper("${var.db_name}_${var.environment}__reader")
    comment = "This role has full access to read the ${var.db_name}_${var.environment} database incl. all schemas."
}

### WHICH TEAMS CAN USE IT? ###
resource "snowflake_role_grants" "database__reader" {
    provider = snowflake.security_admin
    role_name = snowflake_role.database__reader.name
    roles = [
        # Team Roles
        "USR_ROLE_DATA_ENGINEER",
        # App Roles (note that I'm passing in the environmet so that the dbt dev role has access to the dev database, etc.)
        upper("SVC_ROLE_DBT_${var.environment}"),
        "SECURITYADMIN"
    ]
}