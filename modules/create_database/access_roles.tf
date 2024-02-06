/*
This file creates the roles for the database. The roles are used to manage the access to the database.
The roles are created with the following privileges:
- READER: Read access to the database
- WRITER: Write access to the database
The actual permissions for these are defined in `reader_role.tf` and `writer_role.tf`.
*/

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