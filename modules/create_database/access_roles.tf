### HERE WE CREATE THE ACCESS ROLES, AND WHICH TEAM ROLE CAN ACCESS THOSE ROLES ###
# Importantly each resource must be uniquely named, so we have prefixed the
# role - reader - with the name of the database (passed from the environment variable) 
# to ensure uniqueness. If you were securing at the schema level, you would need to 
# prefix with the database name and schema name.

### WHAT IS IT CALLED? ###
resource "snowflake_role" "database__reader" {
    provider = snowflake.security_admin
    name = upper("${var.db_name}__reader")
    comment = "This role has full access to read the ${var.db_name} database incl. all schemas."
}

resource "snowflake_role" "database__writer" {
    provider = snowflake.security_admin
    name = upper("${var.db_name}__writer")
    comment = "This role has full privilege the ${var.db_name} database incl. all schemas."
}