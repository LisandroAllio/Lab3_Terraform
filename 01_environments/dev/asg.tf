# Auto Scaling Group for ECS
resource "aws_autoscaling_group" "ecs" {
  name                = "ecs-asg" #NOMBRE ASG
  vpc_zone_identifier = [aws_subnet.private_a.id, aws_subnet.private_b.id]
  min_size            = 3
  max_size            = 5
  desired_capacity    = 3

  launch_template {
    id      = aws_launch_template.ecs.id
    version = "$Latest"
  }

  tag {
    key                 = "AmazonECSManaged"
    value               = true
    propagate_at_launch = true
  }

  tag {
    key                 = "Name"
    value               = "ECS Instance"
    propagate_at_launch = true
  }

#   tags = {
#     Name        = "ECS Capacity Provider"
#     Environment = "dev"
#     Owner       = "federico"
#   }
}

# Launch Template for EC2 instances
resource "aws_launch_template" "ecs" {
  name_prefix   = "ecs-instance-"
  image_id      = data.aws_ami.ecs_optimized.id  # ECS-optimized AMI
  instance_type = "t2.micro"

  iam_instance_profile {
    arn = aws_iam_instance_profile.ecs_instance.arn
  }

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [aws_security_group.ecs_instances.id]
  }

  user_data = base64encode(<<-EOF
    #!/bin/bash
    echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
  EOF
  )

  tags = {
    Name        = "ECS Launch Template"
    Environment = "dev"
    Owner       = "federico"
  }
}

# Get latest ECS-optimized AMI
data "aws_ami" "ecs_optimized" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-ecs-hvm-*-x86_64-ebs"]
  }
}