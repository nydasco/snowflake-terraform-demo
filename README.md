# Snowflake Terraform Demo

The purpose of this repo is to provide a demonstration of the capability of Terraform to manage your Snowflake infrastructure. The code is relatively simple, and can be adjusted with varying levels of complexity.

At a high level, running this code will generate a number of users and 'team roles', three databases with schemas and 'access roles', and will grant the team roles permissions on the access roles. Additionally some Snowflake warehouses will be created and permissions granted.

> **Note:** The permissions are at the database, not schema level. Obviously this can be changed in the code if that level of permissioning is required.

## Getting set up
In order to use this repo, you will need to have Docker installed, and administrative access to a Snowflake instance. The code that is provided below assumes you're running on a Mac or Linux. You may need to alter some of the commands to run this successfully on Windows.

The below steps through the use of this repo based on the above assumption.
1. Create a public/private key that will be used by a new Terraform account in Snowflake:
```Shell
$ cd ~/.ssh
$ openssl genrsa 2048 | openssl pkcs8 -topk8 -inform PEM -out snowflake_tf_key.p8 -nocrypt
$ openssl rsa -in snowflake_tf_key.p8 -pubout -out snowflake_tf_key.pub
```
2. Within Snowflake, while logged in as `ACCOUNTADMIN` create your new Terraform user:
```SQL
CREATE USER "APP_USR_TERRAFORM" RSA_PUBLIC_KEY='RSA_PUBLIC_KEY_HERE' DEFAULT_ROLE=PUBLIC MUST_CHANGE_PASSWORD=FALSE;

GRANT ROLE SYSADMIN TO USER "APP_USR_TERRAFORM";
GRANT ROLE SECURITYADMIN TO USER "APP_USR_TERRAFORM";
```
Replace `RSA_PUBLIC_KEY_HERE` with the data from the file `snowflake_tf_key.pub` that you generated previously.

3. Clone the repo `git clone https://github.com/nydasco/snowflake-terraform-demo.git`
4. Edit line 23 of the `docker-compose.yml` file, putting in your own Snowflake instance, and location.
5. Ensure Docker is running on your machine.
6. From within the main folder run `docker-compose up`

You will see an output on the screen. Assuming success, you will have been presented with a plan of what Terraform will do if you choose to apply the code. While Terraform needs access to your Snowflake instance to do this, there will be no actual changes made to your environment.

If you want to actually make the changes and create the users / databases / warehouses, then comment out line 15 in the `docker-compose.yml` file, and uncomment line 16. Then run `docker-compose up` again. This will deploy the changes to your environment.

To clean things up, comment line 16 out again, and uncomment line 17. This will back out all of the changes made.

> **Note:** Terraform creates a tfstate file. In this repo, it will create it in the main folder. If you want to deploy this in production, you should look at having it save to a secure S3 bucket or similar.

Good luck with you IaC adventures!
