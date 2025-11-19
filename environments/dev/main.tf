terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  backend "s3" {
    bucket = "s3-backend-teralab3-grupo-1"
    key    = "dev/terraform.tfstate"  # Cambiar key para dev
    region = "us-east-1"
    encrypt = true
    use_lockfile = true
  }
}

#### VPC ####
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "lab3_vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  public_subnets  = ["10.0.0.0/25", "10.0.0.128/25"]
  private_subnets = ["10.0.1.0/25", "10.0.1.128/25"]

  enable_nat_gateway = true
  single_nat_gateway = false  #por default se crean 1 por az. Con esto solo creamos 1

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}