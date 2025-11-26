/*
#### VARIABLES PARA BUILDSPEC ####
module "parameter_store_aws_region" {
  source = "terraform-aws-modules/ssm-parameter/aws"

  name  = "/lab/AWS_REGION"
  value = "us-east-1"
}

module "parameter_store_ecr_registry" {
  source = "terraform-aws-modules/ssm-parameter/aws"

  name  = "/lab/ECR_REGISTRY"
  value = "979244568430.dkr.ecr.us-east-1.amazonaws.com"
}

module "parameter_store_image_repo" {
  source = "terraform-aws-modules/ssm-parameter/aws"
  
  name  = "/lab/ECR_REPOSITORY"
  value = "lab/front"
}

module "parameter_store_container" {
  source = "terraform-aws-modules/ssm-parameter/aws"

  name  = "/lab/CONTAINER_NAME"
  value = "frontend"
}

#### VARIABLES PARA FRONT ####
module "parameter_store_db" {
  source = "terraform-aws-modules/ssm-parameter/aws"

  name  = "/lab3/DB_HOST"
  value = "${module.service_discovery.service_name}.${module.service_discovery.namespace_name}"
  secure_type = true
}

#### VARIABLES PARA BD ####
module "parameter_store_mysql_db" {
  source = "terraform-aws-modules/ssm-parameter/aws"

  name  = "/lab3/mysql/MYSQL_DATABASE"
  value = "sample"
  secure_type = true
}

module "parameter_store_root_pw" {
  source = "terraform-aws-modules/ssm-parameter/aws"

  name  = "/lab3/mysql/MYSQL_ROOT_PASSWORD"
  value = "example"
  secure_type = true
}

module "parameter_store_mysql_user" {
  source = "terraform-aws-modules/ssm-parameter/aws"

  name  = "/lab3/mysql/MYSQL_USER"
  value = "sampleuser"
  secure_type = true
}

module "parameter_store_mysql_pw" {
  source = "terraform-aws-modules/ssm-parameter/aws"

  name  = "/lab3/mysql/MYSQL_PASSWORD"
  value = "samplepass"
  secure_type = true
}
*/