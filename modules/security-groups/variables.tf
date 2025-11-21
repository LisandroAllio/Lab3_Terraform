variable "vpc_id" {
  description = "ID de la VPC donde se crean los security groups"
  type        = string
}

variable "name_prefix" {
  description = "Prefijo para nombrar los security groups"
  type        = string
  default     = "lab-3"
}

variable "environment" {
  description = "Nombre del ambiente para etiquetar los recursos"
  type        = string
  default     = "dev"
}

variable "tags" {
  description = "Tags adicionales a aplicar en todos los security groups"
  type        = map(string)
  default     = {}
}


