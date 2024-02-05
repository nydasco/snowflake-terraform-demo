output "full_db_name" {
  description = "The full name of the database"
  value = snowflake_database.database.name
}