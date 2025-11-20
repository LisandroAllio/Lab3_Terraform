# Obtener Hosted Zone existente
data "aws_route53_zone" "main" {
  name         = "ecastelnuovo.ownboarding.teratest.net."
  private_zone = false
}

# Obtener Certificado ACM existente
data "aws_acm_certificate" "main" {
  domain   = "*.ecastelnuovo.ownboarding.teratest.net"
  statuses = ["ISSUED"]
}

