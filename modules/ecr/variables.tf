variable "name_front" {
    description = "Nombre del repositorio"
    type = string
}

variable "name_bd" {
    description = "Nombre del repositorio"
    type = string
}

variable "image_tag_mutability" {
    description = "Indica si los tags de las imagenes pueden ser mutables o inmutables"
    type = string
}

variable "encryption_type" {
    description = "Tipo de encriptación que utiliza el repositorio"
    type = string
}

variable "scan_on_push" {
    description = "Indica si la imagen va a escanearse al pushearla"
    type = bool
}