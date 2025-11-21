#### IAM Roles ####
module "iam_roles" {
  source = "../../modules/iam-roles"

  instance_profile_name = "ecs-instance-profile"
  instance_role_name    = "ecs-instance-role"

  tags = {
    Name        = "ECS IAM Role"
    Environment = "dev"
    Owner       = "federico"
  }
}