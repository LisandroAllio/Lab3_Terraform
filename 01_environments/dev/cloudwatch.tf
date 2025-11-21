#### CloudWatch Log Groups ####
module "cloudwatch" {
  source = "../../modules/cloudwatch"

  mysql_log_group_name    = "/ecs/mysql"
  frontend_log_group_name = "/ecs/frontend"

  tags = {
    Name        = "ECS Log Groups"
    Environment = "dev"
    Owner       = "federico"
  }
}