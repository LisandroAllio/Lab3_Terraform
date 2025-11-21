# Data source para obtener tu Hosted Zone existente
data "aws_route53_zone" "main" {
  name         = "ecastelnuovo.ownboarding.teratest.net"  # Reemplaza con tu dominio
  private_zone = false
}

#### Route 53 Record ####
module "route53" {
  source = "../../modules/route53"

  zone_id       = data.aws_route53_zone.main.zone_id
  domain_name   = "alb.ecastelnuovo.ownboarding.teratest.net"  # Subdominio que quieres usar
  record_type   = "A"
  alb_dns_name  = module.alb.alb_dns_name
  alb_zone_id   = module.alb.alb_zone_id
}