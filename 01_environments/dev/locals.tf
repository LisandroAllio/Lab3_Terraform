locals {
  # Environment Configuration
  environment = "dev"
  project     = "lab-3"
  region      = "us-east-1"
  
  # Naming Convention
  name_prefix = "${local.project}"
  
  # VPC Configuration
  vpc_name       = "lab3_vpc"
  vpc_cidr       = "10.0.0.0/16"
  azs            = ["${local.region}a", "${local.region}b"]
  subnet_newbits = 9

  public_subnets = [
    cidrsubnet(local.vpc_cidr, local.subnet_newbits, 0),
    cidrsubnet(local.vpc_cidr, local.subnet_newbits, 1),
  ]

  private_subnets = [
    cidrsubnet(local.vpc_cidr, local.subnet_newbits, 2),
    cidrsubnet(local.vpc_cidr, local.subnet_newbits, 3),
  ]

  # ASG Configuration
  asg_name                       = "lab3-asg"
  asg_min_size                   = 3
  asg_max_size                   = 5
  asg_desired_capacity           = 3
  asg_instance_name              = "ECS Instance"
  asg_launch_template_prefix     = "ecs-instance-"
  asg_instance_type              = "t2.micro"
  asg_instance_profile_name      = "ecs-instance-profile"
  asg_instance_role_name         = "ecs-instance-role"
  asg_cluster_name               = "lab3-cluster"

  # CloudWatch Configuration
  mysql_log_group_name    = "/ecs/mysql"
  frontend_log_group_name = "/ecs/frontend"

  # ECR Configuration
  ecr_repo_front_name      = "lab/front"
  ecr_repo_bd_name         = "lab/bd-mysql"
  ecr_image_tag_mutability = "MUTABLE"
  ecr_encryption_type      = "AES256"
  ecr_scan_on_push         = false

  # ECS Cluster Configuration
  ecs_cluster_name           = "lab3-cluster"
  ecs_capacity_provider_name = "lab3-capacity-provider"

  # ECS Tasks Configuration
  task_cpu_units               = "512"
  task_memory_limit            = "512"
  task_container_port_front    = 80
  task_container_port_db       = 3306

  # ECS Frontend Service Configuration
  ecs_frontend_service_name = "frontend-service"
  ecs_frontend_desired_count = 2
  ecs_frontend_container_name = "frontend"
  ecs_frontend_container_port = 80

  # ECS MySQL Service Configuration
  ecs_mysql_service_name = "mysql-service"
  ecs_mysql_desired_count = 1
  ecs_mysql_launch_type = "EC2"

  # EFS Configuration
  efs_performance_mode = "generalPurpose"
  efs_throughput_mode = "bursting"
  efs_encrypted = true
  efs_mysql_uid = 999
  efs_mysql_gid = 999

  # Pipeline Configuration
  codebuild_iam_role_name = "codebuild-role-name"
  codebuild_iam_role_policy_name = "codebuild-role-policy-name"
  codebuild_project_name = "lab3-project"
  s3_bucket_name = "lab3-pipeline-bucket"
  aws_account_id = "979244568430"
  repository_id = "LisandroAllio/php_inter"
  github_connection_name = "lab3-github-connection"

  # Route53 Configuration
  route53_zone_name = "ecastelnuovo.ownboarding.teratest.net"
  route53_domain_name = "alb.ecastelnuovo.ownboarding.teratest.net"
  route53_record_type = "A"

  # Service Discovery Configuration
  service_discovery_namespace_name = "ecs-cluster-namespace"
  service_discovery_namespace_description = "Service Discovery Namespace to use in ECS Cluster"
  service_discovery_service_name = "database"

  # Common Tags
  common_tags = {
    Environment = local.environment
    Project     = local.project
    ManagedBy   = "Terraform"
    Region      = local.region
  }
}
