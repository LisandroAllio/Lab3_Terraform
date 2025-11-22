variable "image_uri_front" {
  description = "URI de la imagen del frontend en ECR"
  type        = string
}

variable "image_uri_db" {
  description = "URI de la imagen de la base de datos en ECR"
  type        = string
}


variable "cpu_units" {
  description = "Unidades de CPU que requiere la tarea"
  type        = string
}

variable "memory_limit" {
  description = "Limite de memoria para la tarea"
  type        = string
}

variable "container_port_front" {
  description = "Puerto expuesto por el contenedor para el frontend"
  type        = number
}

variable "container_port_db" {
  description = "Puerto expuesto por el contenedor para la base de datos"
  type        = number
}

variable "db_host_name" {
  description = "Nombre del parametro dentro de Parameter Store"
  type        = string
}

variable "task_role_arn" {
  description = "El ARN del rol de la tarea"
  type        = string
}

variable "execution_role_arn" {
  description = "El ARN del rol de ejecución para ECS"
  type        = string
}

variable "efs_file_system_id" {
  description = "ID del sistema de archivos EFS"
  type        = string
}

variable "efs_access_point_id" {
  description = "ID del access point de EFS"
  type        = string
}

variable "frontend_log_group_name" {
  description = "Nombre del log group de CloudWatch para el frontend"
  type        = string
}

variable "mysql_log_group_name" {
  description = "Nombre del log group de CloudWatch para MySQL"
  type        = string
}

variable "aws_region" {
  description = "Región de AWS donde se crean los recursos"
  type        = string
  default     = "us-east-1"
}