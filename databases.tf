module "my_database_dev" {
  source = "./modules/my_database"
  db_name = "my_database"
  environment = "dev"
}

module "my_database_stg" {
  source = "./modules/my_database"
  db_name = "my_database"
  environment = "stg"
}

module "my_database_prd" {
  source = "./modules/my_database"
  db_name = "my_database"
  environment = "prd"
}