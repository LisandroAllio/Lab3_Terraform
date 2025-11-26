#### ECR ####
module "ecr" {
  source = "../../modules/ecr"

  repo_front_name      = local.ecr_repo_front_name
  repo_bd_name         = local.ecr_repo_bd_name
  common_tags          = local.common_tags
  image_tag_mutability = local.ecr_image_tag_mutability
  encryption_type      = local.ecr_encryption_type
  scan_on_push         = local.ecr_scan_on_push
  environment          = local.environment
}