module "ecr" {
    source = "../../modules/ecr"

    name_front = "lab/front"
    name_bd = "lab/bd-mysql"
    image_tag_mutability = "MUTABLE"
    encryption_type = "AES256"
    scan_on_push = false
}