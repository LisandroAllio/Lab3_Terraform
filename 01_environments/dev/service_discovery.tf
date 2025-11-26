#### Service Discovery ####
module "service_discovery" {
  source = "../../modules/service-discovery"

  namespace_name        = local.service_discovery_namespace_name
  namespace_description = local.service_discovery_namespace_description
  vpc_id                = module.vpc.vpc_id
  service_name          = local.service_discovery_service_name

  tags = {
    Name        = "Service Discovery"
    Environment = "dev"
    Owner       = "federico"
  }
}