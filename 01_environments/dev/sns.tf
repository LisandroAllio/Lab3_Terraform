#### SNS Topic para Notificaciones del Pipeline ####
# IMPORTANTE: Después de crear este recurso, cada email recibirá un correo de confirmación
# de suscripción que debe ser confirmado haciendo clic en el enlace del correo.
module "sns_pipeline_notifications" {
  source = "../../modules/sns"

  name_prefix      = "lab3-pipeline"
  display_name     = "Lab3 Pipeline Notifications"
  # Configurar las direcciones de correo en terraform.tfvars o mediante variable
  # Ejemplo: email_addresses = ["email1@example.com", "email2@example.com"]
  email_addresses  = var.pipeline_notification_emails
  environment      = "dev"
  aws_account_id   = "979244568430"

  tags = {
    Name        = "Pipeline Notifications"
    Environment = "dev"
    Owner       = "Ezequiel"
  }
}

