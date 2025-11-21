module "ecr" {
  source = "../../modules/ecr"

  image_tag_mutability = "MUTABLE"
  encryption_type      = "AES256"
  scan_on_push         = false
  environment          = "dev"
}