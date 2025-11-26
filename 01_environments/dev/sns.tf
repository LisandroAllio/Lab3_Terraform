variable "pipeline_notification_emails" {
  description = "Correos que recibirán notificaciones del pipeline. Cada email debe confirmar la suscripción enviada por AWS."
  type        = list(string)
  default     = [
    "eze.castelnuovo@gmail.com",
    "fedelibra98@gmail.com",
    "alliolisandro@gmail.com",
    "lara.speranza6@gmail.com"
  ]
}

module "sns_pipeline_notifications" {
  source = "../../modules/sns"

  name_prefix         = local.name_prefix
  pipeline_name       = module.codepipeline.pipeline_name
  email_subscriptions = var.pipeline_notification_emails
  tags = merge(local.common_tags, {
    Owner = "Ezequiel"
  })
}
