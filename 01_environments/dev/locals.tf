locals {
  vpc_cidr       = "10.0.0.0/16"
  azs = ["us-east-1a", "us-east-1b"]
  subnet_newbits = 9

  public_subnets = [
    cidrsubnet(local.vpc_cidr, local.subnet_newbits, 0),
    cidrsubnet(local.vpc_cidr, local.subnet_newbits, 1),
  ]

  private_subnets = [
    cidrsubnet(local.vpc_cidr, local.subnet_newbits, 2),
    cidrsubnet(local.vpc_cidr, local.subnet_newbits, 3),
  ]
}