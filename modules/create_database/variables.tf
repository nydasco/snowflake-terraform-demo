# A variable block, which contains the variables we'll pass into the module.

variable "db_name" {
    type = string
    description = "The name of the database"
}

variable "schema_name" {
    type = map(string)
    description = "The schemas and their comments for the database"
}