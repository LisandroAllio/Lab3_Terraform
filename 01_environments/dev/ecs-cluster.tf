# ECS Cluster
resource "aws_ecs_cluster" "main" {
  name = "my-ecs-cluster" #NOMBRE CLUSTER

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Name        = "My ECS Cluster"
    Environment = "dev"
    Owner       = "federico"
  }
}

# Capacity Provider linked to ASG
resource "aws_ecs_capacity_provider" "asg" {
  name = "my-capacity-provider" #NOMBRE CAPACITY PROVIDER

  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.ecs.arn
    managed_termination_protection = "ENABLED"

    managed_scaling {
      status          = "ENABLED"
      target_capacity = 100  # Target utilization percentage
      minimum_scaling_step_size = 1
      maximum_scaling_step_size = 10
    }
  }

  tags = {
    Name        = "ECS Capacity Provider"
    Environment = "dev"
    Owner       = "federico"
  }
}

# Associate Capacity Provider with Cluster
resource "aws_ecs_cluster_capacity_providers" "main" {
  cluster_name = aws_ecs_cluster.main.name

  capacity_providers = [aws_ecs_capacity_provider.asg.name]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = aws_ecs_capacity_provider.asg.name
  }

#   tags = {
#     Name        = "ECS Capacity Provider"
#     Environment = "dev"
#     Owner       = "federico"
#   }
}