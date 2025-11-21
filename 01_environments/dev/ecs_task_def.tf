#### Task Definition Frontend ####
module "task_definition_frontend" {
    source = "../../modules/ecs-tasks"

    image_uri          = "${module.ecr.front_repository_url}:latest"
    cpu_units          = "512"
    memory_limit       = "512"
    container_port     = 80
    db_host_name       = module.parameter_store.ssm_parameter_name
    task_role_arn      = module.iam_roles.instance_role_arn
    execution_role_arn = module.iam_roles.ecs_execution_role_arn
}