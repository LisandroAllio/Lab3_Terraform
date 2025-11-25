variable "name_prefix" {
  description = "Prefijo para el nombre del topic SNS"
  type        = string
  default     = "lab3"
}

variable "topic_name" {
  description = "Nombre del topic SNS (opcional, se genera automáticamente si no se especifica)"
  type        = string
  default     = null
}

variable "display_name" {
  description = "Nombre para mostrar del topic SNS"
  type        = string
  default     = null
}

variable "email_addresses" {
  description = "Lista de direcciones de correo para suscribir al topic"
  type        = list(string)
}

variable "environment" {
  description = "Entorno (dev, prod, etc.)"
  type        = string
  default     = "dev"
}

variable "aws_account_id" {
  description = "ID de la cuenta de AWS"
  type        = string
}

variable "kms_key_id" {
  description = "ID de la clave KMS para cifrar el topic (opcional)"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags adicionales para los recursos"
  type        = map(string)
  default     = {}
}

