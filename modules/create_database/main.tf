### MAIN FILE THAT SHOULDN'T NEED TO BE ALTERED ###
# Best practice is not to manage Snowflake with the ACCOUNT ADMIN role
# but instead to use the SYSADMIN role and then leverage the SECURITYADMIN
# role where necessary.

terraform {
  required_version = "= 1.7.0"

  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "~> 0.85"
    }
  }
}

# SYSADMIN role has the ability to create databases, schemas & warehouses. This is the default.
# SECURITYADMIN role has the ability to create users, roles & grant privileges. 

provider "snowflake" {
  role = "SYSADMIN"
}

provider "snowflake" {
  alias = "security_admin"
  role = "SECURITYADMIN"
}