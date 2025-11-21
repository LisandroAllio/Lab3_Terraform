#### Service Discovery ####
module "service_discovery" {
  source = "../../modules/service-discovery"

  namespace_name        = "ecs-cluster-namespace"
  namespace_description = "Service Discovery Namespace to use in ECS Cluster"
  vpc_id                = module.vpc.vpc_id
  service_name          = "database"

  tags = {
    Name        = "Service Discovery"
    Environment = "dev"
    Owner       = "federico"
  }
}