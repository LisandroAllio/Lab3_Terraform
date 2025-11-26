module "codebuild_project" {
    source = "../../modules/code_build"
    codebuild_iam_role_name = local.codebuild_iam_role_name
    codebuild_iam_role_policy_name = local.codebuild_iam_role_policy_name
    codebuild_project_name = local.codebuild_project_name
}

module "codepipeline" {
  source = "../../modules/pipeline"
  codebuild_project_name = module.codebuild_project.codebuild_project_name
  s3_bucket_name = local.s3_bucket_name
  aws_region = local.region
  aws_account_id = local.aws_account_id
  ecs_cluster_name = local.ecs_cluster_name
  ecs_service_name = local.ecs_frontend_service_name
  repository_id = local.repository_id
  github_connection_name = local.github_connection_name
  #sns_topic_arn = module.sns_pipeline_notifications.topic_arn
}