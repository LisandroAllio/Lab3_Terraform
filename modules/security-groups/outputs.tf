output "alb_security_group_id" {
  description = "Security group ID para el Application Load Balancer"
  value       = aws_security_group.alb.id
}

output "task_front_security_group_id" {
  description = "Security group ID para las ECS tasks del frontend"
  value       = aws_security_group.task_front.id
}

output "task_mysql_security_group_id" {
  description = "Security group ID para la base de datos MySQL"
  value       = aws_security_group.task_mysql.id
}

output "efs_security_group_id" {
  description = "Security group ID para el filesystem EFS de MySQL"
  value       = aws_security_group.efs.id
}

output "cluster_security_group_id" {
  description = "Security group ID para las instancias del cluster ECS"
  value       = aws_security_group.cluster.id
}


