# snowflake-terraform-demo

This is a barebones Terraform structure for setting up a Snowflake instance

Running the docker-compose and passing in the Terraform parameters will result in the creation of users, warehouses and a database. It will also assign a default read permission to the user role.

It is important to note that this code can't simply be run 'as is' but rather will need to be modified for the setup you are looking for. The intent is that this provides a structure than can be followed and built out on.

Terraform is designed to use a modular approach to code deployment. In a Snowflake environment, it is less likely that you will simply be able to define the structure and security for a generic 'database' and keep that in a module. However, you may be able to use a module to replicate changes across dev/stg/prd versions of a database if you are distinguishing these by the code related to the tables as opposed to the structure and permissions on the database itself. Additionally, I've found that using modules assists in breaking the files down into logical groups, as Terraform does not allow for the use of folders without modules.
