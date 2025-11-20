# resource "aws_vpc" "example" {
#   cidr_block           = "10.0.0.0/16"
#   enable_dns_support   = true
#   enable_dns_hostnames = true
# }

resource "aws_service_discovery_private_dns_namespace" "CloudMap Namespace" {
  name        = "cluster-namespace"
  description = "namespace to use in ECS cluster for database service discovery"
  vpc         = #especificar VPC

  tags = {
    Name        = "CloudMap Namespace"
    Environment = "dev"
    Owner       = "federico"
  }
}

resource "aws_service_discovery_service" "CloudMap Service" {
  name = "database"

  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.cluster-namespace.id

    dns_records {
      ttl  = 10
      type = "A"
    }

    routing_policy = "MULTIVALUE"
  }

  health_check_config {
    failure_threshold = 1
  }

  tags = {
    Name        = "CloudMap Service"
    Environment = "dev"
    Owner       = "federico"
  }
}