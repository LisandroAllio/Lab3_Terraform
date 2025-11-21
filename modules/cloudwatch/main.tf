resource "aws_cloudwatch_log_group" "mysql_log" {
  name = var.mysql_log_group_name
  tags = var.tags
}

resource "aws_cloudwatch_log_group" "frontend_log" {
  name = var.frontend_log_group_name
  tags = var.tags
}