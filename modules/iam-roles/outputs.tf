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

output "task_execution_role_arn" {
  description = "ARN of the ECS task execution role"
  value       = aws_iam_role.ecs_task_execution.arn
}

output "task_execution_role_name" {
  description = "Name of the ECS task execution role"
  value       = aws_iam_role.ecs_task_execution.name
}

output "parameter_store_policy_arn" {
  description = "ARN of the parameter store policy"
  value       = aws_iam_policy.parameter_store_read.arn
}