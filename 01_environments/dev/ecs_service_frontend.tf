#### ECS Service - Frontend ####

module "ecs_frontend" {
  source = "../../modules/ecs-frontend"

  service_name        = local.ecs_frontend_service_name
  cluster_id          = module.ecs_cluster.cluster_id
  task_definition_arn = module.ecs_tasks.task_definition_front_arn
  desired_count       = local.ecs_frontend_desired_count

  subnet_ids         = module.vpc.private_subnets
  security_group_ids = [module.security_groups.ecs_tasks_security_group_id]
  target_group_arn   = module.alb.target_group_arn
  container_name     = local.ecs_frontend_container_name
  container_port     = local.ecs_frontend_container_port

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


