# Auto Scaling Group for ECS
resource "aws_autoscaling_group" "ecs" {
  name                = var.asg_name
  vpc_zone_identifier = var.subnet_ids
  min_size            = var.min_size
  max_size            = var.max_size
  desired_capacity    = var.desired_capacity

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
    value               = var.instance_name
    propagate_at_launch = true
  }
  tag {
    key                 = "Cluster"
    value               = var.cluster_name
    propagate_at_launch = true
  }
  tag {
    key                 = "Environment"
    value               = var.tags.Environment
    propagate_at_launch = true
  }
  tag {
    key                 = "Owner"
    value               = var.tags.Owner
    propagate_at_launch = true
  }
}

# Launch Template for EC2 instances
resource "aws_launch_template" "ecs" {
  name_prefix   = var.launch_template_prefix
  image_id      = data.aws_ami.ecs_optimized.id
  instance_type = var.instance_type

  iam_instance_profile {
    arn = var.iam_instance_profile_arn
  }

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = var.security_group_ids
  }

  user_data = base64encode(templatefile("${path.module}/user_data.sh", {
    cluster_name = var.cluster_name
  }))

  tags = var.tags
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