### CONEXION GITHUB ###
/**import {
  to = module.codepipeline.aws_codestarconnections_connection.git_connection
  id = "arn:aws:codeconnections:us-east-1:979244568430:connection/4559c724-bd4c-4af9-929b-8d1448d57c7b"
}*/

module "codebuild_project" {
    source = "../../modules/code_build"
    codebuild_iam_role_name = "codebuild-role-name"
    codebuild_iam_role_policy_name = "codebuild-role-policy-name"
    codebuild_project_name = "lab3-project"
}

module "codepipeline" {
  source = "../../modules/pipeline"
  codebuild_project_name = module.codebuild_project.codebuild_project_name
  # codepipeline_role_name = "lab-front-pipeline-role" // this is the default value
  s3_bucket_name = "lab3-pipeline-bucket"
  aws_region = "us-east-1"
  aws_account_id = "979244568430"
  ecs_cluster_name = "lab3-cluster"
  ecs_service_name = "frontend-service"
  repository_id = "LisandroAllio/php_inter"
  sns_topic_arn = module.sns_pipeline_notifications.topic_arn
}