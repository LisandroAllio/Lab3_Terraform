#### Task Definition Frontend ####
module "task-definition-frontend" {
    source = "../../modules/ecs-tasks"

    image_uri = "${module.ecr.front_repository_url}:latest"
    cpu_units = "512"
    memory_limit = "512"
    container_port = 80
    db_host = module.parameter_store.value
    task_role_arn = module.iam_roles.instance_role_arn
}