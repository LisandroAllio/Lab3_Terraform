locals {
  # Environment Configuration
  environment = "dev"
  project     = "lab-3"
  region      = "us-east-1"
  
  # Naming Convention
  name_prefix = "${local.project}"
  
  # VPC Configuration
  vpc_cidr       = "10.0.0.0/16"
  azs            = ["${local.region}a", "${local.region}b"]
  subnet_newbits = 9

  public_subnets = [
    cidrsubnet(local.vpc_cidr, local.subnet_newbits, 0),
    cidrsubnet(local.vpc_cidr, local.subnet_newbits, 1),
  ]

  private_subnets = [
    cidrsubnet(local.vpc_cidr, local.subnet_newbits, 2),
    cidrsubnet(local.vpc_cidr, local.subnet_newbits, 3),
  ]
  
  # Common Tags
  common_tags = {
    Environment = local.environment
    Project     = local.project
    ManagedBy   = "Terraform"
    Region      = local.region
  }
}
