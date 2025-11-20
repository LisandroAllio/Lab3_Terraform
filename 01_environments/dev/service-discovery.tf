resource "aws_service_discovery_private_dns_namespace" "ecs-cluster-namespace" {
  name        = "ecs-cluster-namespace"
  description = "Service Discovery Namespace to use in ECS Cluster"
  vpc         = module_vpc.vpc.id

  tags = {
    Name        = "Terraform State Bucket"
    Environment = "dev"
    Owner       = "federico"
  }
}

resource "aws_service_discovery_service" "service-discovery-service" {
  name = "database"

  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.ecs-cluster-namespace.id

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
    Name        = "Terraform State Bucket"
    Environment = "dev"
    Owner       = "federico"
  }
}