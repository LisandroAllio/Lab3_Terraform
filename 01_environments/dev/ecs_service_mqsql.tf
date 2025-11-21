#### ECS Service - MySQL ####
module "ecs_mysql" {
  source = "../../modules/ecs-mysql"

  service_name        = "mysql-service"
  cluster_id          = module.ecs_cluster.cluster_id
  task_definition_arn = "db-task:1"
  desired_count       = 1
  launch_type         = "EC2"

  subnet_ids         = module.vpc.private_subnets
  security_group_ids = [module.security_groups.mysql_security_group_id]

  tags = {
    Name        = "MySQL Service"
    Environment = "dev"
    Owner       = "lisandro"
  }
}