locals {
  frontend_env = [
    { name = "DB_HOST", value = var.db_host }
  ]

  frontend_container = [{
    name        = "frontend"
    image       = var.image_uri
    essential   = true
    portMappings = [
      {
        containerPort = var.container_port
        hostPort      = var.container_port
      }
    ]
    environment = local.frontend_env 
  }]
}

resource "aws_ecs_task_definition" "task_definition_front" {
  family = "front_task_def"
  network_mode = "awsvpc"
  cpu = var.cpu_units
  memory = var.memory_limit
  task_role_arn = var.task_role_arn
  container_definitions = jsonencode(local.frontend_container)
}