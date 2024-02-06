### CREATE THE DATABASE AND SCHEMAS ###
# The variables are passed into this Terraform file, including the database name
# and the environment. Here we simply need to copy/paste down the 4 line code blocks
# for the schemas that exist within the database, and change the name and comments.

resource "snowflake_database" "database" {
  name = upper("${var.db_name}")
  comment = "Example database creation"
}

resource "snowflake_schema" "database__schema" {
  for_each = var.schema_name
  name     = each.key
  database = upper("${var.db_name}")
  comment  = each.value
  depends_on = [
    snowflake_database.database
  ]
}
