#### EFS ####
module "efs" {
  source = "../../modules/efs"

  name_prefix           = "lab-3"
  environment           = "dev"
  private_subnet_ids    = module.vpc.private_subnets
  efs_security_group_id = module.security_groups.efs_security_group_id

  # Configuración de rendimiento
  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"
  encrypted        = true

  # Configuración MySQL
  mysql_uid = 999
  mysql_gid = 999

  tags = {
    Owner = "Ezequiel"
  }
}
