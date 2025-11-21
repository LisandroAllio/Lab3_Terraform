output "asg_arn" {
  description = "ARN of the Auto Scaling Group"
  value       = aws_autoscaling_group.ecs.arn
}

output "asg_name" {
  description = "Name of the Auto Scaling Group"
  value       = aws_autoscaling_group.ecs.name
}

output "launch_template_id" {
  description = "ID of the launch template"
  value       = aws_launch_template.ecs.id
}