module "my_database" {
  source = "./modules/my_database"
  db_name = "my_database"
  environment = "dev"
}

module "my_database" {
  source = "./modules/my_database"
  db_name = "my_database"
  environment = "tst"
}

module "my_database" {
  source = "./modules/my_database"
  db_name = "my_database"
  environment = "prd"
}