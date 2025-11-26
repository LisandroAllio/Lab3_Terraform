#### Task Definition Frontend y Database ####
module "ecs_tasks" {
  source = "../../modules/ecs-tasks"

  image_uri_front         = "${module.ecr.front_repository_url}:latest"
  image_uri_db            = "${module.ecr.bd_repository_url}:latest"
  cpu_units               = "512"
  memory_limit            = "512"
  container_port_front    = 80
  container_port_db       = 3306
  db_host_name            = "/lab3/DB_HOST"
  db_name                 = "/lab3/mysql/MYSQL_DATABASE"
  db_user                 = "/lab3/mysql/MYSQL_USER"
  db_pass                 = "/lab3/mysql/MYSQL_PASSWORD"
  db_root_pass            = "/lab3/mysql/MYSQL_ROOT_PASSWORD"
  task_execution_role_name   = "ecs-task-execution-role"
  parameter_store_role_name  = "ecs-parameter-store-read-v2"
  common_tags               = local.common_tags
  efs_file_system_id      = module.efs.efs_file_system_id
  efs_access_point_id     = module.efs.efs_access_point_id
  frontend_log_group_name = module.cloudwatch.frontend_log_group_name
  mysql_log_group_name    = module.cloudwatch.mysql_log_group_name
  aws_region              = "us-east-1"
}