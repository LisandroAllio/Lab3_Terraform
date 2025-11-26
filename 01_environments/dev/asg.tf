#### Auto Scaling Group ####
module "ecs_asg" {
  source = "../../modules/ecs-asg"

  asg_name                   = local.asg_name
  subnet_ids                 = module.vpc.private_subnets
  min_size                   = local.asg_min_size
  max_size                   = local.asg_max_size
  desired_capacity           = local.asg_desired_capacity
  instance_name              = local.asg_instance_name
  launch_template_prefix     = local.asg_launch_template_prefix
  instance_type              = local.asg_instance_type
  instance_profile_name      = local.asg_instance_profile_name
  instance_role_name         = local.asg_instance_role_name
  security_group_ids         = [module.security_groups.cluster_security_group_id]
  cluster_name               = local.asg_cluster_name
  
  tags = {
    Name        = "ECS Launch Template"
    Environment = "dev"
    Owner       = "federico"
  }
}