#### ECS Service - Base de datos ####
resource "aws_ecs_service" "service" {
  name            = var.service_name
  cluster         = var.cluster_id
  task_definition = var.task_definition_arn
  desired_count   = var.desired_count
  launch_type     = var.launch_type

  force_delete = true  # Forces deletion even if tasks are running

  network_configuration {
    subnets          = var.subnet_ids
    security_groups  = var.security_group_ids
    assign_public_ip = false
  }

  # Deployment configuration para distribuir las tasks según requerimientos
  #Deployment strategy = Rolling update (por default)
  deployment_minimum_healthy_percent = 0
  deployment_maximum_percent         = 100


  service_registries {
    registry_arn = var.service_discovery_arn
  }

  tags = var.tags
}