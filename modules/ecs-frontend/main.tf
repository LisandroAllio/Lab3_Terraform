#### ECS Service - Frontend ####
resource "aws_ecs_service" "frontend" {
  name            = var.service_name
  cluster         = var.cluster_id
  task_definition = var.task_definition_arn
  desired_count   = var.desired_count

  force_delete = true  # Forces deletion even if tasks are running

  launch_type = "EC2"

  network_configuration {
    subnets          = var.subnet_ids
    security_groups  = var.security_group_ids
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }

  # Deployment configuration para distribuir las tasks según requerimientos
  #Deployment strategy = Rolling update (por default)
  deployment_minimum_healthy_percent = 0
  deployment_maximum_percent         = 100

  # Placement strategies para distribuir las tasks según requerimientos
  ordered_placement_strategy {
    type  = "spread"
    field = "instanceId"
  }

  ordered_placement_strategy {
    type  = "spread"
    field = "attribute:ecs.availability-zone"
  }

  depends_on = [var.dependencies]

  tags = var.tags
}