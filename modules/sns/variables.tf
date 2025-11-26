variable "name_prefix" {
  description = "Prefijo usado para nombrar los recursos de SNS"
  type        = string
}

variable "pipeline_name" {
  description = "Nombre del pipeline cuyo estado se va a monitorear"
  type        = string
}

variable "stage_name" {
  description = "Nombre del stage que se monitoreará para eventos de inicio (por defecto Source)"
  type        = string
  default     = "Source"
}

variable "email_subscriptions" {
  description = "Direcciones de correo que recibirán las notificaciones"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Map de tags a aplicar en los recursos SNS"
  type        = map(string)
  default     = {}
}

