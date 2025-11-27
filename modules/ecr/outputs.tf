output "front_repository_url" {
  description = "La URL completa del repositorio ECR del Frontend."
  value       = aws_ecr_repository.repositorio_front.repository_url
}

output "front_repository_arn" {
  description = "El ARN del repositorio ECR del Frontend."
  value       = aws_ecr_repository.repositorio_front.arn
}

output "bd_repository_url" {
  description = "La URL completa del repositorio ECR de la Base de Datos."
  value       = aws_ecr_repository.repositorio_bd.repository_url
}

output "bd_repository_arn" {
  description = "El ARN del repositorio ECR de la Base de Datos."
  value       = aws_ecr_repository.repositorio_bd.arn
}