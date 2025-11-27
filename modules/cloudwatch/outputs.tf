output "mysql_log_group_name" {
  description = "Name of the MySQL log group"
  value       = aws_cloudwatch_log_group.mysql_log.name
}

output "mysql_log_group_arn" {
  description = "ARN of the MySQL log group"
  value       = aws_cloudwatch_log_group.mysql_log.arn
}

output "frontend_log_group_name" {
  description = "Name of the frontend log group"
  value       = aws_cloudwatch_log_group.frontend_log.name
}

output "frontend_log_group_arn" {
  description = "ARN of the frontend log group"
  value       = aws_cloudwatch_log_group.frontend_log.arn
}