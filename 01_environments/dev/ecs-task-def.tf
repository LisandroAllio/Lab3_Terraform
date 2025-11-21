module "task-definition-frontend" {
    source = "../../modules/ecs-tasks"

    image_uri = "${module.ecr.front_repository_url}:latest"
    cpu_units = "512"
    memory_limit = "512"
    container_port = 80
    db_host = "${aws_service_discovery_service.service-discovery-service.name}.${aws_service_discovery_private_dns_namespace.ecs-cluster-namespace.name}"
    task_role_arn = aws_iam_role.ecs_instance.arn
    //execution_role_arn = ""
}