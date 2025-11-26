# Data source para obtener tu certificado ACM existente
# Comentado debido a permisos insuficientes (SCP deny)
/*
data "aws_acm_certificate" "main" {
  domain      = "*.ecastelnuovo.ownboarding.teratest.net"
  statuses    = ["ISSUED"]
  most_recent = true
}
*/

locals {
  certificate_arn = "arn:aws:acm:us-east-1:979244568430:certificate/df0471fa-a89b-4f10-b975-635a2912dd1a"
}

#### ALB & Target Group ####
module "alb" {
  source = "../../modules/alb"

  vpc_id          = module.vpc.vpc_id
  subnets_ids     = module.vpc.public_subnets
  certificate_arn = local.certificate_arn
  security_group_ids = [
    module.security_groups.alb_security_group_id
  ]
  target_group_name   = "${local.name_prefix}-target-group"
  alb_name = "${local.name_prefix}-alb"
  common_tags = local.common_tags
  environment = local.environment
}