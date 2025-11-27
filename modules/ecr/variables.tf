variable "image_tag_mutability" {
  description = "Indica si los tags de las imagenes pueden ser mutables o inmutables"
  type        = string
}

variable "encryption_type" {
  description = "Tipo de encriptación que utiliza el repositorio"
  type        = string
}

variable "scan_on_push" {
  description = "Indica si la imagen va a escanearse al pushearla"
  type        = bool
}

variable "repo_front_name" {
  description = "Nombre de del repositorio ECR con front"
  type = string
}

variable "repo_bd_name" {
  description = "Nombre de del repositorio ECR con bd"
  type = string
}

variable "common_tags" {
  description = "Tags comunes aplicados desde el entorno"
  type        = map(string)
  default     = {}
}

variable "environment" {
  default = "dev"
}
