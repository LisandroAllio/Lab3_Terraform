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