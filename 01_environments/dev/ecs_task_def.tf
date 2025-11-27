#### Task Definition Frontend y Database ####
module "ecs_tasks" {
  source = "../../modules/ecs-tasks"
  
  #General Configurations
  cpu_units               = local.task_cpu_units
  memory_limit            = local.task_memory_limit
  task_execution_role_name   = "ecs-task-execution-role"
  parameter_store_role_name  = "ecs-parameter-store-read-v2"
  aws_region              = local.region
  
  #Front Configurations
  image_uri_front         = "${module.ecr.front_repository_url}:latest"
  container_port_front    = local.task_container_port_front
  db_host_name            = module.parameter_store_db.name
  frontend_log_group_name = module.cloudwatch.frontend_log_group_name
  
  #BD Configurations
  image_uri_db            = "${module.ecr.bd_repository_url}:latest"
  container_port_db       = local.task_container_port_db
  db_name                 = data.aws_ssm_parameter.mysql_database.name
  db_user                 = data.aws_ssm_parameter.mysql_user.name
  db_pass                 = data.aws_ssm_parameter.mysql_password.name
  db_root_pass            = data.aws_ssm_parameter.mysql_root_password.name
  efs_file_system_id      = module.efs.efs_file_system_id
  efs_access_point_id     = module.efs.efs_access_point_id
  mysql_log_group_name    = module.cloudwatch.mysql_log_group_name

  common_tags               = local.common_tags
}