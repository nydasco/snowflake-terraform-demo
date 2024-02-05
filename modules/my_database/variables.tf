# A variable block, which contains the variables we'll pass into the module.

variable "db_name" {
    type = string
    description = "The name of the database"
    default = "my_database"
}

variable "environment" {
    type = string
    description = "Environment that the database exists in - dev/stg/prd - that will be appended to the database name"
    default = "dev"
}