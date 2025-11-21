output "instance_profile_arn" {
  description = "ARN of the IAM instance profile"
  value       = aws_iam_instance_profile.ecs_instance.arn
}

output "instance_profile_name" {
  description = "Name of the IAM instance profile"
  value       = aws_iam_instance_profile.ecs_instance.name
}

output "instance_role_arn" {
  description = "ARN of the IAM instance role"
  value       = aws_iam_role.ecs_instance.arn
}

output "instance_role_name" {
  description = "Name of the IAM instance role"
  value       = aws_iam_role.ecs_instance.name
}

output "ecs_execution_role_arn" {
  description = "ARN of the IAM ecs execution role"
  value       = aws_iam_role.ecs_task_execution.arn
}