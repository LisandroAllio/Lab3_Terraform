#### EFS ####
module "efs" {
  source = "../../modules/efs"

  name_prefix           = local.name_prefix
  environment           = local.environment
  private_subnet_ids    = module.vpc.private_subnets
  efs_security_group_id = module.security_groups.efs_security_group_id

  # Configuración de rendimiento
  performance_mode = local.efs_performance_mode
  throughput_mode  = local.efs_throughput_mode
  encrypted        = local.efs_encrypted

  # Configuración MySQL
  mysql_uid = local.efs_mysql_uid
  mysql_gid = local.efs_mysql_gid

  tags = {
    Owner = "Ezequiel"
  }
}
