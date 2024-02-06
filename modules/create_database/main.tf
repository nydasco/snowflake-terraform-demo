/*
 Each module needs the configuration added to it.
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

provider "snowflake" {
  role = "SYSADMIN"
}

provider "snowflake" {
  alias = "security_admin"
  role = "SECURITYADMIN"
}