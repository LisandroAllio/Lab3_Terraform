module "security_groups" {
  source = "../../modules/security-groups"

  vpc_id      = module.vpc.vpc_id
  name_prefix = "lab-3"
  environment = "dev"
}