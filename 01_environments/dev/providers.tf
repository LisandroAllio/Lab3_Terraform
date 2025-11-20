provider "aws" {
  region = "us-east-1" # Misma región que usas en tu módulo VPC
}
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  backend "s3" {
    bucket       = "s3-backend-teralab3-grupo-1"
    key          = "dev/terraform.tfstate" # Cambiar key para dev
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}
