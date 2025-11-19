terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

module "vpc" {
  source = "../../modules/vpc"

  name = "lab3_vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  public_subnets  = ["10.0.0.0/25", "10.0.0.128/25"]
  private_subnets = ["10.0.1.0/25", "10.0.1.128/25"]

  enable_nat_gateway = true
  single_nat_gateway = true  #por default se crean 1 por az. Con esto solo creamos 1
}