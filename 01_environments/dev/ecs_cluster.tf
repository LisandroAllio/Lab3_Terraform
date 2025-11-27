#### ECS Cluster ####
module "ecs_cluster" {
  source = "../../modules/ecs-cluster"

  cluster_name           = local.ecs_cluster_name
  capacity_provider_name = local.ecs_capacity_provider_name
  asg_arn                = module.ecs_asg.asg_arn

  tags = {
    Name        = "My ECS Cluster"
    Environment = "dev"
    Owner       = "federico"
  }

  # depends_on = [module.ecs_asg]
}