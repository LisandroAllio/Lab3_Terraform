#### ECS Service - Frontend ####
/*
module "ecs_frontend" {
  source = "../../modules/ecs-frontend"

  service_name        = "frontend-service"
  cluster_id          = module.ecs_cluster.cluster_id
  task_definition_arn = "PLACEHOLDER_TASK_DEFINITION_ARN" # TODO: Reemplazar con module.ecs_task_frontend.task_definition_arn
  desired_count       = 2

  subnet_ids         = module.vpc.private_subnets
  security_group_ids = [module.security_groups.ecs_tasks_security_group_id]
  target_group_arn   = module.alb.target_group_arn
  container_name     = "frontend"
  container_port     = 80

  dependencies = [
    module.alb,
    module.ecs_cluster
  ]

  tags = {
    Name        = "Frontend Service"
    Environment = "dev"
    Owner       = "Ezequiel"
  }
}
*/

