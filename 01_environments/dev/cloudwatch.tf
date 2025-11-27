#### CloudWatch Log Groups ####
module "cloudwatch" {
  source = "../../modules/cloudwatch"

  mysql_log_group_name    = local.mysql_log_group_name
  frontend_log_group_name = local.frontend_log_group_name

  tags = {
    Name        = "ECS Log Groups"
    Environment = "dev"
    Owner       = "federico"
  }
}