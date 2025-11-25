variable "codebuild_project_name" {
  description = "Name of the CodeBuild project to use in the pipeline"
  type        = string
}

variable "s3_bucket_name" {
  description = "Name for the S3 bucket to store pipeline artifacts"
  type        = string
}

variable "repository_id" {
  description = "GitHub repository ID in format owner/repo"
  type        = string
  default     = "federicogfb/teralab2"
}

variable "ecs_cluster_name" {
  description = "Name of the ECS cluster for deployment"
  type        = string
  default     = "lab3-cluster"
}

variable "ecs_service_name" {
  description = "Name of the ECS service for deployment"
  type        = string
  default     = "frontend-service"
}

variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "us-east-1"
}

variable "aws_account_id" {
  description = "AWS account ID"
  type        = string
  default     = "979244568430"
}

variable "codepipeline_role_name" {
  description = "Name for the role that CodePipeline will use"
  type = string
  default = "lab-front-pipeline-role"
}

variable "github_connection_name" {
  description = "Name for the GitHub CodeStar connection"
  type        = string
  default     = "github-connection"
}