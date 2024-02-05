### CREATE THE DATABASE AND SCHEMAS ###
# The variables are passed into this Terraform file, including the database name
# and the environment. Here we simply need to copy/paste down the 4 line code blocks
# for the schemas that exist within the database, and change the name and comments.

locals {
  database_schemas = {
    "RAW" = {
      comment = "contains raw data from our source systems"
    }
    "PRESENTATION" = {
      comment = "contains tables and views accessible to analysts and reporting"
    }
  }
}

resource "snowflake_database" "database" {
  name = upper("${var.db_name}_${var.environment}")
  comment = "Example database creation"
}

resource "snowflake_schema" "database__schema" {
  for_each = local.database_schemas
  name     = each.key
  database = upper("${var.db_name}_${var.environment}")
  comment  = each.value.comment
  depends_on = [
    snowflake_database.database
  ]
}
