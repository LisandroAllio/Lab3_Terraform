terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "s3-backend-teralab3-grupo-1"
    key    = "backend/terraform.tfstate"
    region = "us-east-1"
    use_lockfile = true
    encrypt = true
  }

}