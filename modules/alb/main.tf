resource "aws_lb_target_group" "target_group" {
    name     = "lab-target-group"
    port     = 80
    protocol = "HTTP"
    target_type = "ip"
    vpc_id   = var.vpc_id

    tags = {
        Name        = "Target Group"
        Environment = var.environment
        Owner       = "Lara"
    }
}

resource "aws_lb" "alb" {
    name               = "lab-alb"
    internal           = false
    load_balancer_type = "application"
    security_groups    = var.security_group_ids
    subnets = var.subnets_ids

    tags = {
        Name        = "ECR Repository Base de Datos"
        Environment = var.environment
        Owner       = "Lara"
    }
}

resource "aws_lb_listener" "listener_https" {
    load_balancer_arn = aws_lb.alb.arn
    port              = "443"
    protocol          = "HTTPS"
    certificate_arn   = var.certificate_arn

    default_action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.target_group.arn
    }
}

resource "aws_lb_listener" "listener_http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}