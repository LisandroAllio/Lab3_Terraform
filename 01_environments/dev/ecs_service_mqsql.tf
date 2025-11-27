#### ECS Service - MySQL ####
module "ecs_mysql" {
  source = "../../modules/ecs-mysql"

  service_name        = local.ecs_mysql_service_name
  cluster_id          = module.ecs_cluster.cluster_id
  task_definition_arn = module.ecs_tasks.task_definition_db_arn
  desired_count       = local.ecs_mysql_desired_count
  launch_type         = local.ecs_mysql_launch_type

  subnet_ids         = module.vpc.private_subnets
  security_group_ids = [module.security_groups.mysql_security_group_id]

  service_discovery_arn = module.service_discovery.service_arn

  tags = {
    Name        = "MySQL Service"
    Environment = "dev"
    Owner       = "lisandro"
  }

}