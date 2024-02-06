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