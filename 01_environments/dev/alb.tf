# Data source para obtener tu certificado ACM existente
/*
data "aws_acm_certificate" "main" {
  domain      = "*.ecastelnuovo.ownboarding.teratest.net"    # O "tudominio.com" si es específico
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
  environment = "dev"
}