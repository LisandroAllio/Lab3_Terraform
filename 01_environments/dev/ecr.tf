#### ECR ####
module "ecr" {
  source = "../../modules/ecr"

  repo_front_name      = "lab/front"
  repo_bd_name         = "lab/bd-mysql"
  common_tags          = local.common_tags
  image_tag_mutability = "MUTABLE"
  encryption_type      = "AES256"
  scan_on_push         = false
  environment          = local.environment
}