#### IAM Roles ####
module "iam_roles" {
  source = "../../modules/iam-roles"

  instance_profile_name      = "ecs-instance-profile"
  instance_role_name         = "ecs-instance-role"
  task_execution_role_name   = "ecs-task-execution-role"
  parameter_store_role_name  = "ecs-parameter-store-read"

  tags = {
    Name        = "ECS IAM Role"
    Environment = "dev"
    Owner       = "federico"
  }
}