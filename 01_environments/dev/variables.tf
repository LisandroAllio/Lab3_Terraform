variable "pipeline_notification_emails" {
  description = "Lista de direcciones de correo para recibir notificaciones del pipeline. IMPORTANTE: Después de crear el recurso, cada email recibirá un correo de confirmación de suscripción que debe ser confirmado."
  type        = list(string)
  default     = [
    "eze.castelnuovo@gmail.com",
    "fedelibra98@gmail.com",
    "alliolisandro@gmail.com",
    "lara.speranza6@gmail.com"
  ]
}

