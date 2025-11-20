locals {
  name_front        = "lab/front"
  name_bd           = "lab/bd-mysql"
}

resource "aws_ecr_repository" "repositorio_front" {
  name                 = local.name_front
  image_tag_mutability = var.image_tag_mutability
  encryption_configuration {
    encryption_type = var.encryption_type
  }

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  tags = {
    Name        = "ECR Repository Frontend"
    Environment = var.environment
    Owner       = "Lara"
  }
}

resource "aws_ecr_repository" "repositorio_bd" {
  name                 = local.name_bd
  image_tag_mutability = var.image_tag_mutability

  encryption_configuration {
    encryption_type = var.encryption_type
  }
  
  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  tags = {
    Name        = "ECR Repository Base de Datos"
    Environment = var.environment
    Owner       = "Lara"
  }
}
