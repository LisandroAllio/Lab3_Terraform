resource "aws_ecr_repository" "repositorio_front" {
  name                 = var.name_front
  image_tag_mutability = var.image_tag_mutability_front
  
  encryption_configuration {
    encryption_type = var.encryption_type_front
  }

  image_scanning_configuration {
    scan_on_push = var.scan_on_push_front
  }
}

resource "aws_ecr_repository" "repositorio_bd" {
  name                 = var.name_bd
  image_tag_mutability = var.image_tag_mutability_bd

  encryption_configuration {
    encryption_type = var.image_tag_mutability_bd
  }
  
  image_scanning_configuration {
    scan_on_push = var.scan_on_push_bd
  }
}
