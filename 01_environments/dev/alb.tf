# ALB & Target Group
module "alb" {
  source = "../../modules/alb"

  vpc_id          = module.vpc.vpc_id
  subnets_ids     = module.vpc.public_subnets
  certificate_arn = "" #Agregar
  security_group_ids = [module.security_groups.alb_security_group_id]
}
