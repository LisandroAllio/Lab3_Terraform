variable "zone_id" {
  description = "ID de la Hosted Zone de Route 53"
  type        = string
}

variable "domain_name" {
  description = "Nombre del dominio/subdominio para el registro"
  type        = string
}

variable "record_type" {
  description = "Tipo de registro DNS"
  type        = string
  default     = "A"
}

variable "alb_dns_name" {
  description = "DNS name del ALB"
  type        = string
}

variable "alb_zone_id" {
  description = "Zone ID del ALB"
  type        = string
}

variable "evaluate_target_health" {
  description = "Si evaluar la salud del target"
  type        = bool
  default     = true
}