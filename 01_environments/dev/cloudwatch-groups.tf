resource "aws_cloudwatch_log_group" "mysql-log" {
  name = "/ecs/mysql"
}

resource "aws_cloudwatch_log_group" "frontend-log" {
  name = "/ecs/frontend"
}

# Log streams se generan automaticamente mediante las task definition.