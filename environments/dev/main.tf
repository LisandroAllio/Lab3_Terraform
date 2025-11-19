module "ecr" {
    source = "../../modules/ecr"

    name_front = "lab/front"
    image_tag_mutability_front = "MUTABLE"
    encryption_type_front = "AES256"
    scan_on_push_front = false

    name_bd = "lab/bd-mysql"
    image_tag_mutability_bd = "MUTABLE"
    encryption_type_bd = "AES256"
    scan_on_push_bd = false
}