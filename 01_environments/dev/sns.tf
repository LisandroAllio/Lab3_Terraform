#### Variable para emails de notificaciones ####
# variable "pipeline_notification_emails" {
#   description = "Lista de direcciones de correo para recibir notificaciones del pipeline. IMPORTANTE: Después de crear el recurso, cada email recibirá un correo de confirmación de suscripción que debe ser confirmado haciendo clic en el enlace del correo."
#   type        = list(string)
#   default     = [
#     "eze.castelnuovo@gmail.com",
#     "fedelibra98@gmail.com",
#     "alliolisandro@gmail.com",
#     "lara.speranza6@gmail.com"
#   ]
# }

#### SNS Topic para Notificaciones del Pipeline ####
/*
module "sns_pipeline_notifications" {
  source = "../../modules/sns"

  name_prefix      = "lab3-pipeline"
  display_name     = "Lab3 Pipeline Notifications"
  email_addresses  = [
    "eze.castelnuovo@gmail.com",
    "fedelibra98@gmail.com",
    "alliolisandro@gmail.com",
    "lara.speranza6@gmail.com"
  ]
  environment      = "dev"
  aws_account_id   = "979244568430"

  tags = {
    Name  = "Pipeline Notifications"
    Owner = "Ezequiel"
  }
}
*/