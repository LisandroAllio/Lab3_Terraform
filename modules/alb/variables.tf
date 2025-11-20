variable "vpc_id" {
    description = "ID de la VPC para el ALB"
    type = string
}

variable "subnets_ids" {
    description = "Lista de IDs de las subnets para el ALB"
    type = set(string)
}

variable "certificate_arn" {
  description = "El ARN del certificado SSL para HTTPS"
  type        = string
}

variable "security_group_ids" {
  description = "Lista de IDs de Security Group para el ALB"
  type        = list(string)
}

variable "environment" {
  default     = "dev"
}
