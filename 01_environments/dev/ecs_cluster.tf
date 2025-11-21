#### ECS Cluster ####
module "ecs_cluster" {
  source = "../../modules/ecs-cluster"

  cluster_name           = "my-ecs-cluster"
  capacity_provider_name = "my-capacity-provider"
  asg_arn                = module.ecs_asg.asg_arn

  tags = {
    Name        = "My ECS Cluster"
    Environment = "dev"
    Owner       = "federico"
  }

  depends_on = [module.ecs_asg]
}