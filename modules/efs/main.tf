# EFS File System
resource "aws_efs_file_system" "mysql_efs" {
  creation_token = "${var.name_prefix}-mysql-efs"

  performance_mode = var.performance_mode
  throughput_mode  = var.throughput_mode
  encrypted        = var.encrypted

  tags = merge(
    {
      Name        = "${var.name_prefix}-mysql-efs"
      Environment = var.environment
      ManagedBy   = "Terraform"
    },
    var.tags
  )
}

# EFS Mount Targets - uno por subnet privada
resource "aws_efs_mount_target" "mysql_efs_mount" {
  count = length(var.private_subnet_ids)

  file_system_id  = aws_efs_file_system.mysql_efs.id
  subnet_id       = var.private_subnet_ids[count.index]
  security_groups = [var.efs_security_group_id]
}

# EFS Access Point para MySQL
resource "aws_efs_access_point" "mysql_access_point" {
  file_system_id = aws_efs_file_system.mysql_efs.id

  posix_user {
    gid = var.mysql_gid
    uid = var.mysql_uid
  }

  root_directory {
    path = "/mysql-data"

    creation_info {
      owner_gid   = var.mysql_gid
      owner_uid   = var.mysql_uid
      permissions = "755"
    }
  }

  tags = merge(
    {
      Name        = "${var.name_prefix}-mysql-access-point"
      Environment = var.environment
      ManagedBy   = "Terraform"
    },
    var.tags
  )
}
