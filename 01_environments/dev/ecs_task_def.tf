#### Task Definition Frontend y Database ####
module "tasks_definitions" {
    source = "../../modules/ecs-tasks"

    image_uri_front      = "${module.ecr.front_repository_url}:latest"
    image_uri_db         = "${module.ecr.bd_repository_url}:latest"
    cpu_units            = "512"
    memory_limit         = "512"
    container_port_front = 80
    container_port_db    = 3306
    db_host_name         = module.parameter_store.ssm_parameter_name
    task_role_arn        = module.iam_roles.instance_role_arn
    execution_role_arn   = module.iam_roles.ecs_execution_role_arn
}