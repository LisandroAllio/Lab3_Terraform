output "efs_file_system_id" {
  description = "ID del EFS file system"
  value       = aws_efs_file_system.mysql_efs.id
}

output "efs_file_system_arn" {
  description = "ARN del EFS file system"
  value       = aws_efs_file_system.mysql_efs.arn
}

output "efs_dns_name" {
  description = "DNS name del EFS file system"
  value       = aws_efs_file_system.mysql_efs.dns_name
}

output "efs_access_point_id" {
  description = "ID del EFS access point para MySQL"
  value       = aws_efs_access_point.mysql_access_point.id
}

output "efs_access_point_arn" {
  description = "ARN del EFS access point para MySQL"
  value       = aws_efs_access_point.mysql_access_point.arn
}

output "efs_mount_target_ids" {
  description = "IDs de los mount targets del EFS"
  value       = aws_efs_mount_target.mysql_efs_mount[*].id
}
