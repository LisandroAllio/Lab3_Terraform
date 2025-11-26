locals {
  topic_name = var.topic_name != null ? var.topic_name : "${var.name_prefix}-pipeline-notifications"
}

# SNS Topic para notificaciones del pipeline
resource "aws_sns_topic" "pipeline_notifications" {
  name              = local.topic_name
  display_name      = var.display_name != null ? var.display_name : "Pipeline Notifications"
  kms_master_key_id = var.kms_key_id

  tags = merge(var.common_tags, var.tags, {
    Name = local.topic_name
  })
}

# Suscripción por email
resource "aws_sns_topic_subscription" "email" {
  count     = length(var.email_addresses)
  topic_arn = aws_sns_topic.pipeline_notifications.arn
  protocol  = "email"
  endpoint  = var.email_addresses[count.index]
}

# Política para permitir que CodePipeline publique en el topic
resource "aws_sns_topic_policy" "pipeline_publish" {
  arn = aws_sns_topic.pipeline_notifications.arn

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "codepipeline.amazonaws.com"
        }
        Action   = "SNS:Publish"
        Resource = aws_sns_topic.pipeline_notifications.arn
        Condition = {
          StringEquals = {
            "aws:SourceAccount" = var.aws_account_id
          }
        }
      }
    ]
  })
}

