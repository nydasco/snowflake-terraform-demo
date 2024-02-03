# snowflake-terraform-demo

This is a barebones Terraform structure for setting up a Snowflake instance

Running the docker-compose and passing in the Terraform parameters will result in the creation of users, warehouses and a database. It will also assign a default read permission to the user role.

It is important to note that this code can't simply be run 'as is' but rather will need to be modified for the setup you are looking for. The intent is that this provides a structure than can be followed and built out on.

Terraform is designed to use a modular approach to code deployment, however modules have not been used in this example. In real world scenarios, I have not found value in modules when related to Snowflake. It is unlikely that you would want to manage multiple databases, or multiple user groups in the same way. Even a dev/stg/prd database collection would likely want to be managed independently (so you could double check everything works in dev before moving forward to higher environments).
