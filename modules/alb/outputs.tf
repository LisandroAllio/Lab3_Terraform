output "alb_dns_name" {
  description = "El nombre de DNS generado por AWS para el Application Load Balancer."
  value       = aws_lb.alb.dns_name
}

output "alb_arn" {
  description = "El ARN del Application Load Balancer."
  value       = aws_lb.alb.arn
}

output "target_group_arn" {
  description = "El ARN del Target Group principal para las tareas de ECS."
  value       = aws_lb_target_group.target_group.arn
}
