
#### VPC ####
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "lab3_vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  public_subnets  = ["10.0.0.0/25", "10.0.0.128/25"]
  private_subnets = ["10.0.1.0/25", "10.0.1.128/25"]

  enable_nat_gateway = true
  single_nat_gateway = false
  one_nat_gateway_per_az = false

  tags = {
    Name        = "VPC"
    Terraform   = "true"
    Environment = "dev"
    Owner       = "Lisandro"
  }
}


#### Security Groups ####
module "security_groups" {
  source = "../../modules/security-groups"

  vpc_id      = module.vpc.vpc_id
  name_prefix = "lab-3"
  environment = "dev"
}



#### ALB & Target Group ####
module "alb" {
  source = "../../modules/alb"

  vpc_id          = module.vpc.vpc_id
  subnets_ids     = module.vpc.public_subnets
  certificate_arn = "" #Agregar
  security_group_ids = [
    module.security_groups.alb_security_group_id
  ]
  environment = "dev"
}

#### ECR ####
module "ecr" {
  source = "../../modules/ecr"

  image_tag_mutability = "MUTABLE"
  encryption_type      = "AES256"
  scan_on_push         = false
  environment          = "dev"
}

