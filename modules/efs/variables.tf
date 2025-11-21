variable "name_prefix" {
  description = "Prefijo para nombrar los recursos EFS"
  type        = string
}

variable "environment" {
  description = "Nombre del ambiente"
  type        = string
  default     = "dev"
}

variable "private_subnet_ids" {
  description = "Lista de IDs de subnets privadas donde crear mount targets"
  type        = list(string)
}

variable "efs_security_group_id" {
  description = "ID del security group para EFS"
  type        = string
}

variable "performance_mode" {
  description = "Modo de rendimiento del EFS (generalPurpose o maxIO)"
  type        = string
  default     = "generalPurpose"
}

variable "throughput_mode" {
  description = "Modo de throughput del EFS (bursting o provisioned)"
  type        = string
  default     = "bursting"
}

variable "encrypted" {
  description = "Si el EFS debe estar encriptado"
  type        = bool
  default     = true
}

variable "mysql_uid" {
  description = "UID para el usuario MySQL en el access point"
  type        = number
  default     = 999
}

variable "mysql_gid" {
  description = "GID para el grupo MySQL en el access point"
  type        = number
  default     = 999
}

variable "tags" {
  description = "Tags adicionales a aplicar en todos los recursos EFS"
  type        = map(string)
  default     = {}
}
