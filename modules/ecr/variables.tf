variable "name_front" {
    description = "Nombre del repositorio"
    type = string
}

variable "image_tag_mutability_front" {
    description = "Indica si los tags de las imagenes pueden ser mutables o inmutables"
    type = string
}

variable "encryption_type_front" {
    description = "Tipo de encriptación que utiliza el repositorio"
    type = string
}

variable "scan_on_push_front" {
    description = "Indica si la imagen va a escanearse al pushearla"
    type = bool
}

variable "name_bd" {
    description = "Nombre del repositorio"
    type = string
}

variable "image_tag_mutability_bd" {
    description = "Indica si los tags de las imagenes pueden ser mutables o inmutables"
    type = string
}

variable "encryption_type_bd" {
    description = "Tipo de encriptación que utiliza el repositorio"
    type = string
}

variable "scan_on_push_bd" {
    description = "Indica si la imagen va a escanearse al pushearla"
    type = bool
}