/*
  This Terraform configuration file sets the required version of Terraform and the required provider for Snowflake.
  
  Terraform Version: 1.7.0
  Provider: Snowflake-Labs/snowflake (version ~> 0.85)
*/

terraform {
  required_version = "= 1.7.0"

  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "~> 0.85"
    }
  }
}

/*
 SYSADMIN role has the ability to create databases, schemas & warehouses. This is the default.
 SECURITYADMIN role has the ability to create users, roles & grant privileges. 
 Note: Don't simply use ACCOUNTADMIN, as this is not best practice.
*/

provider "snowflake" {
  role = "SYSADMIN"
}

provider "snowflake" {
  alias = "security_admin"
  role = "SECURITYADMIN"
}