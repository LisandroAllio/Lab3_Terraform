#### DATA SOURCES PARA LEER PARAMETROS EXISTENTES ####
#### VARIABLES PARA BUILDSPEC ####
data "aws_ssm_parameter" "aws_region" {
  name = "/lab/AWS_REGION"
}

data "aws_ssm_parameter" "ecr_registry" {
  name = "/lab/ECR_REGISTRY"
}

data "aws_ssm_parameter" "ecr_repository" {
  name = "/lab/ECR_REPOSITORY"
}

data "aws_ssm_parameter" "container_name" {
  name = "/lab/CONTAINER_NAME"
}

#### VARIABLES PARA FRONT ####
data "aws_ssm_parameter" "db_host" {
  name = "/lab3/DB_HOST"
}

#### VARIABLES PARA BD ####
data "aws_ssm_parameter" "mysql_database" {
  name = "/lab3/mysql/MYSQL_DATABASE"
}

data "aws_ssm_parameter" "mysql_root_password" {
  name = "/lab3/mysql/MYSQL_ROOT_PASSWORD"
}

data "aws_ssm_parameter" "mysql_user" {
  name = "/lab3/mysql/MYSQL_USER"
}

data "aws_ssm_parameter" "mysql_password" {
  name = "/lab3/mysql/MYSQL_PASSWORD"
}