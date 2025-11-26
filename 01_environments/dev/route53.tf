# Data source para obtener tu Hosted Zone existente
data "aws_route53_zone" "main" {
  name         = local.route53_zone_name
  private_zone = false
}

#### Route 53 Record ####
module "route53" {
  source = "../../modules/route53"

  zone_id       = data.aws_route53_zone.main.zone_id
  domain_name   = local.route53_domain_name
  record_type   = local.route53_record_type
  alb_dns_name  = module.alb.alb_dns_name
  alb_zone_id   = module.alb.alb_zone_id
}