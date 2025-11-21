data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

locals {
  region_id  = data.aws_region.current.id
  account_id = data.aws_caller_identity.current.account_id

  common_tags = {
    Environment = "dev"
    Owner       = "Lara"
  }
}

resource "aws_ecs_task_definition" "task_definition_front" {
  family                = "front_task_def"
  network_mode          = "awsvpc"
  cpu                   = var.cpu_units
  memory                = var.memory_limit
  task_role_arn         = var.task_role_arn
  execution_role_arn    = var.execution_role_arn
  container_definitions = jsonencode([
    {
      name         = "frontend"
      image        = var.image_uri
      essential    = true
      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.container_port
        }
      ]
      secrets = [{ name = "DB_HOST", valueFrom = "arn:aws:ssm:${local.region_id}:${local.account_id}:parameter/${var.db_host_name}"}]
    }
  ])
  tags = merge(local.common_tags, {
    Name = "Task Definition Frontend"
  })
}