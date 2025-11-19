resource "aws_ecr_repository" "repositorio_front" {
  name                 = var.name_front
  image_tag_mutability = var.image_tag_mutability
  encryption_configuration {
    encryption_type = var.encryption_type
  }

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }
}

resource "aws_ecr_repository" "repositorio_bd" {
  name                 = var.name_bd
  image_tag_mutability = var.image_tag_mutability

  encryption_configuration {
    encryption_type = var.image_tag_mutability
  }
  
  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }
}
