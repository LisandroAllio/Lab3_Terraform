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
  family             = "front_task_def"
  network_mode       = "awsvpc"
  task_role_arn      = "" #Agregar
  execution_role_arn = "" #Agregar
  container_definitions = jsonencode([
    {
      name      = "frontend"
      image     = "" #Agregar
      cpu       = 10
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
      environment = [
        { name = "DB_HOST", value = "..." }
      ]
    }
  ])
}