module "parameter_store_db" {
  source = "terraform-aws-modules/ssm-parameter/aws"

  name  = "/lab3/DB_HOST"
  value = "${module.service_discovery.service_name}.${module.service_discovery.namespace_name}"
  secure_type = true
  tags  = {
    Name        = "Parameter Store"
    Environment = "dev"
    Owner       = "Lara"
  }
}

module "parameter_store_aws_region" {
  source = "terraform-aws-modules/ssm-parameter/aws"

  name  = "/lab/AWS_DEFAULT_REGION"
  value = "us-east-1"
  tags  = {
    Name        = "Parameter Store"
    Environment = "dev"
    Owner       = "federico"
  }
}

module "parameter_store_account_id" {
  source = "terraform-aws-modules/ssm-parameter/aws"

  name  = "/lab/AWS_ACCOUNT_ID"
  value = "979244568430"
  tags  = {
    Name        = "Parameter Store"
    Environment = "dev"
    Owner       = "federico"
  }
}

module "parameter_store_image_repo" {
  source = "terraform-aws-modules/ssm-parameter/aws"

  name  = "/lab/IMAGE_REPO_NAME"
  value = "lab-front-repo"
  tags  = {
    Name        = "Parameter Store"
    Environment = "dev"
    Owner       = "federico"
  }
}

module "parameter_store_container" {
  source = "terraform-aws-modules/ssm-parameter/aws"

  name  = "/lab/CONTAINER_NAME"
  value = "php-container"
  tags  = {
    Name        = "Parameter Store"
    Environment = "dev"
    Owner       = "federico"
  }
}