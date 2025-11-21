# ECS Cluster
resource "aws_ecs_cluster" "main" {
  name = var.cluster_name

  setting {
    name  = "containerInsights"
    value = var.container_insights
  }

  tags = var.tags
}

# Capacity Provider linked to ASG
resource "aws_ecs_capacity_provider" "asg" {
  name = var.capacity_provider_name

  auto_scaling_group_provider {
    auto_scaling_group_arn         = var.asg_arn
    managed_termination_protection = var.managed_termination_protection

    managed_scaling {
      status                    = var.managed_scaling_status
      target_capacity           = var.target_capacity
      minimum_scaling_step_size = var.minimum_scaling_step_size
      maximum_scaling_step_size = var.maximum_scaling_step_size
    }
  }

  tags = var.tags
}

# Associate Capacity Provider with Cluster
resource "aws_ecs_cluster_capacity_providers" "main" {
  cluster_name = aws_ecs_cluster.main.name

  capacity_providers = [aws_ecs_capacity_provider.asg.name]

  default_capacity_provider_strategy {
    base              = var.capacity_provider_base
    weight            = var.capacity_provider_weight
    capacity_provider = aws_ecs_capacity_provider.asg.name
  }
}