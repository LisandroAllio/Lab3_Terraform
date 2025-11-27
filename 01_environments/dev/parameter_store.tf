#### VARIABLES PARA BUILDSPEC ####
data "aws_ssm_parameter" "aws_region" {
  name = "/lab/AWS_REGION"
  with_decryption = true
}

data "aws_ssm_parameter" "ecr_registry" {
  name = "/lab/ECR_REGISTRY"
  with_decryption = true
}

data "aws_ssm_parameter" "ecr_repository" {
  name = "/lab/ECR_REPOSITORY"
  with_decryption = true
}

data "aws_ssm_parameter" "container_name" {
  name = "/lab/CONTAINER_NAME"
  with_decryption = true
}

#### VARIABLES PARA BD ####
data "aws_ssm_parameter" "mysql_database" {
  name = "/lab3/mysql/MYSQL_DATABASE"
  with_decryption = true
}

data "aws_ssm_parameter" "mysql_root_password" {
  name = "/lab3/mysql/MYSQL_ROOT_PASSWORD"
  with_decryption = true
}

data "aws_ssm_parameter" "mysql_user" {
  name = "/lab3/mysql/MYSQL_USER"
  with_decryption = true
}

data "aws_ssm_parameter" "mysql_password" {
  name = "/lab3/mysql/MYSQL_PASSWORD"
  with_decryption = true
}

### VARIABLE Conexion de Front y BD ###
module "parameter_store_db" {
  source = "terraform-aws-modules/ssm-parameter/aws"

  name  = "/lab3/DB_HOST"
  value = "${module.service_discovery.service_name}.${module.service_discovery.namespace_name}"
  secure_type = true
}

