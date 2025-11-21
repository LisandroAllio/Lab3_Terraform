output "alb_security_group_id" {
  description = "Security group ID para el Application Load Balancer"
  value       = aws_security_group.alb.id
}

output "ecs_tasks_security_group_id" {
  description = "Security group ID para las ECS tasks del frontend"
  value       = aws_security_group.ecs_tasks.id
}

output "mysql_security_group_id" {
  description = "Security group ID para la base de datos MySQL"
  value       = aws_security_group.mysql.id
}

output "efs_security_group_id" {
  description = "Security group ID para el filesystem EFS de MySQL"
  value       = aws_security_group.mysql_efs.id
}

output "cluster_security_group_id" {
  description = "Security group ID para las instancias del cluster ECS"
  value       = aws_security_group.cluster.id
}


