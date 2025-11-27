# Data source para obtener tu certificado ACM existente
data "aws_acm_certificate" "main" {
  domain      = "*.ecastelnuovo.ownboarding.teratest.net"
  statuses    = ["ISSUED"]
  most_recent = true
}

#### ALB & Target Group ####
module "alb" {
  source = "../../modules/alb"

  vpc_id          = module.vpc.vpc_id
  subnets_ids     = module.vpc.public_subnets
  certificate_arn = data.aws_acm_certificate.main.arn
  security_group_ids = [
    module.security_groups.alb_security_group_id
  ]
  target_group_name   = "${local.name_prefix}-target-group"
  alb_name = "${local.name_prefix}-alb"
  common_tags = local.common_tags
  environment = local.environment
}