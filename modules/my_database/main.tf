terraform {
  required_version = ">= 0.14"

  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "~> 0.71"
    }
  }
}