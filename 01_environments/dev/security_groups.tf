#### Security Groups ####
module "security_groups" {
  source = "../../modules/security-groups"

  vpc_id      = module.vpc.vpc_id
  name_prefix = local.name_prefix
  environment = local.environment
  common_tags = local.common_tags
  tags = {
    Owner = "Ezequiel"
  }
}