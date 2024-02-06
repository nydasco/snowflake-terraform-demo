/*
 An outputs.tf file allows values to be passed back out of the module to the main Terraform configuration.
 In our case, this is passing back the name of the database and the roles created for the database.
*/

output "full_db_name" {
  description = "The full name of the database"
  value = snowflake_database.database.name
}

output "reader" {
  description = "Read only role for the database"
  value = snowflake_role.database__reader.name
}

output "writer" {
  description = "All permissions role for the database"
  value = snowflake_role.database__writer.name
}