

resource "aws_ecr_repository" "repositorio_front" {
  force_delete = true
  name                 = var.repo_front_name
  image_tag_mutability = var.image_tag_mutability
  encryption_configuration {
    encryption_type = var.encryption_type
  }

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  tags = merge(var.common_tags, {
    Name        = "ECR Repository Frontend"
    Owner       = "Lara"
  })

}

resource "aws_ecr_repository" "repositorio_bd" {
  force_delete = true
  name                 = var.repo_bd_name
  image_tag_mutability = var.image_tag_mutability

  encryption_configuration {
    encryption_type = var.encryption_type
  }

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  tags = merge(var.common_tags, {
    Name        = "ECR Repository Base de Datos"
    Owner       = "Lara"
  })
}
