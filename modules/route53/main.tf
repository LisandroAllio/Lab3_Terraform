#### Route 53 Record ####
# Registro A que apunta al ALB
resource "aws_route53_record" "alb" {
  zone_id = var.zone_id
  name    = var.domain_name
  type    = var.record_type

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = var.evaluate_target_health
  }
}