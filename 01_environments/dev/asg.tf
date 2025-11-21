#### Auto Scaling Group ####
module "ecs_asg" {
  source = "../../modules/ecs-asg"

  asg_name                   = "ecs-asg"
  subnet_ids                 = module.vpc.private_subnets
  min_size                   = 3
  max_size                   = 5
  desired_capacity           = 3
  instance_name              = "ECS Instance"
  launch_template_prefix     = "ecs-instance-"
  instance_type              = "t2.micro"
  iam_instance_profile_arn   = module.iam_roles.instance_profile_arn
  security_group_ids         = [module.security_groups.cluster_security_group_id]
  cluster_name               = "my-ecs-cluster"

  tags = {
    Name        = "ECS Launch Template"
    Environment = "dev"
    Owner       = "federico"
  }
}