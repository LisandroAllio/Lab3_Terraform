output "topic_arn" {
  description = "ARN del topic SNS"
  value       = aws_sns_topic.pipeline_notifications.arn
}

output "topic_name" {
  description = "Nombre del topic SNS"
  value       = aws_sns_topic.pipeline_notifications.name
}

output "subscription_arns" {
  description = "ARNs de las suscripciones creadas"
  value       = [for subscription in aws_sns_topic_subscription.emails : subscription.arn]
}

