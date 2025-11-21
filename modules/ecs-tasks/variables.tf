variable "image_uri" {
    description = "URI de la imagen del frontend en ECR"
    type = string
}

variable "cpu_units" {
    description = "Unidades de CPU que requiere la tarea"
    type = string
}

variable "memory_limit" {
    description = "Limite de memoria para la tarea"
    type = string
}

variable "container_port" {
    description = "Puerto expuesto por el contenedor"
    type = number
}

variable "db_host_name" {
    description = "Nombre del parametro dentro de Parameter Store"
    type = string
}

variable "task_role_arn" {
    description = "El ARN del rol de la tarea"
    type = string
}

variable "execution_role_arn" {
    description = "El ARN del rol de ejecución para ECS"
    type = string
}