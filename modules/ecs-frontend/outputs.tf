output "service_id" {
  description = "ID of the ECS service"
  value       = aws_ecs_service.frontend.id
}

output "service_name" {
  description = "Name of the ECS service"
  value       = aws_ecs_service.frontend.name
}

output "service_arn" {
  description = "ARN of the ECS service"
  value       = aws_ecs_service.frontend.id
}