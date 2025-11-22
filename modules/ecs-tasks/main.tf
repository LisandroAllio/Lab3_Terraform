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
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture = "X86_64"
  }
  container_definitions = jsonencode([
    {
      name         = "frontend"
      image        = var.image_uri_front
      essential    = true
      portMappings = [
        {
          containerPort = var.container_port_front
          hostPort      = var.container_port_front
        }
      ]
      secrets = [{ name = "DB_HOST", valueFrom = "arn:aws:ssm:${local.region_id}:${local.account_id}:parameter${var.db_host_name}"}]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = var.frontend_log_group_name
          "awslogs-region"        = var.aws_region
          "awslogs-stream-prefix" = "ecs"
        }
      }
    }
  ])
  tags = merge(local.common_tags, {
    Name = "Task Definition Frontend"
  })
}

resource "aws_ecs_task_definition" "task_definition_db" {
  family                = "db_task_def"
  network_mode          = "awsvpc"
  cpu                   = var.cpu_units
  memory                = var.memory_limit
  task_role_arn         = var.task_role_arn
  execution_role_arn    = var.execution_role_arn
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture = "X86_64"
  }
  volume {
    name = "lab-3-mysql-efs"

    efs_volume_configuration {
      file_system_id          = var.efs_file_system_id
      transit_encryption      = "ENABLED"
      authorization_config {
        access_point_id = var.efs_access_point_id
      }
    }
  }
  container_definitions = jsonencode([
    {
      name         = "database"
      image        = var.image_uri_db
      essential    = true
      portMappings = [
        {
          containerPort = var.container_port_db
          hostPort      = var.container_port_db
        }
      ]
      mountPoints = [
        {
          sourceVolume  = "lab-3-mysql-efs" 
          containerPath = "/var/lib/mysql"       
          readOnly      = false
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = var.mysql_log_group_name
          "awslogs-region"        = var.aws_region
          "awslogs-stream-prefix" = "ecs"
        }
      }
    }
  ])

  tags = merge(local.common_tags, {
    Name = "Task Definition Database"
  })
}