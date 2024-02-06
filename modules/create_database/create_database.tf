/*
  This file is used to create a database and schemas within Snowflake. 
  The database name and schema names are passed in as variables from the 
  main Terraform file. 
*/

resource "snowflake_database" "database" {
  name = upper("${var.db_name}")
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
