/*
 Here we define a set of warehouses, and then the resource will iterate through them. Then we can assign the warehouse 
 to the role that needs it.
*/

locals {
    warehouses = {
        "USR_WH_SMALL" = {
            warehouse_size = "small"
        },
        "USR_WH_MEDIUM" = {
            warehouse_size = "medium"
        }
    }
}

resource "snowflake_warehouse" "warehouse" {
    for_each = local.warehouses
    name = each.key
    warehouse_size = each.value.warehouse_size
    auto_suspend   = 60
}

### ALLOW USAGE OF THE WAREHOUSES ###
resource "snowflake_grant_privileges_to_account_role" "warehouse_usage__usr_role_data_engineer__usr_wh_small" {
    provider = snowflake.security_admin
    privileges = ["USAGE"]
    account_role_name  = snowflake_role.team_role["USR_ROLE_DATA_ENGINEER"].id
    on_account_object {
        object_type = "WAREHOUSE"
        object_name = snowflake_warehouse.warehouse["USR_WH_SMALL"].id
    }
}