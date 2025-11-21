output "namespace_id" {
  description = "ID of the service discovery namespace"
  value       = aws_service_discovery_private_dns_namespace.ecs_cluster_namespace.id
}

output "namespace_arn" {
  description = "ARN of the service discovery namespace"
  value       = aws_service_discovery_private_dns_namespace.ecs_cluster_namespace.arn
}

output "namespace_name"{
  description = "Name of the service discovery namespace"
  value       = aws_service_discovery_private_dns_namespace.ecs_cluster_namespace.name
}

output "service_id" {
  description = "ID of the service discovery service"
  value       = aws_service_discovery_service.service_discovery_service.id
}

output "service_arn" {
  description = "ARN of the service discovery service"
  value       = aws_service_discovery_service.service_discovery_service.arn
}

output "service_name"{
  description = "Name of the service discovery service"
  value       = aws_service_discovery_service.service_discovery_service.name
}
