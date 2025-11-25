module "codebuild_project" {
    source = "../../modules/code_build"
    codebuild_iam_role_name = "codebuild-role-name"
    codebuild_iam_role_policy_name = "codebuild-role-policy-name"
    codebuild_project_name = "lab3-project"
}

module "codepipeline" {
  source = "../../modules/pipeline"
  codebuild_project_name = module.codebuild_project.codebuild_project_name
  s3_bucket_name = "lab3-pipeline-bucket"
  aws_region = "us-east-1"
  aws_account_id = "979244568430"
  ecs_cluster_name = "lab3-cluster"
  ecs_service_name = "frontend-service"
  repository_id = "LisandroAllio/php_inter"
  github_connection_name = "lab3-github-connection"
}