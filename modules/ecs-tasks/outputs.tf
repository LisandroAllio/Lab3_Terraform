output "task_definition_arn" {
  description = "El ARN de la Task Definition del Frontend."
  value       = aws_ecs_task_definition.task_definition_front.arn
}

output "task_definition_family" {
  description = "El nombre de la familia de la Task Definition."
  value       = aws_ecs_task_definition.task_definition_front.family
}