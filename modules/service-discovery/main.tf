resource "aws_service_discovery_private_dns_namespace" "ecs_cluster_namespace" {
  name        = var.namespace_name
  description = var.namespace_description
  vpc         = var.vpc_id

  tags = var.tags
}

resource "aws_service_discovery_service" "service_discovery_service" {
  name = var.service_name

  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.ecs_cluster_namespace.id

    dns_records {
      ttl  = var.dns_ttl
      type = var.dns_type
    }

    routing_policy = var.routing_policy
  }



  tags = var.tags
}