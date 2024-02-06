/*
 A variable block allows us to define the structure of variables that we'll pass into the module.
 In this case it's the name of the database, and a map of schema names and their comments.
*/

variable "db_name" {
    type = string
    description = "The name of the database"
}

variable "schema_name" {
    type = map(string)
    description = "The schemas and their comments for the database"
}