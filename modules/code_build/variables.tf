variable "codebuild_iam_role_name" {
  description = "name for the iam role that will use CodeBuild"
  type = string
}

variable "codebuild_iam_role_policy_name" {
  description = "name for the inline policy that will adapt the iam role that will use CodeBuild"
  type = string
}

variable "codebuild_project_name" {
  description = "name for the CodeBuild Project"
  type = string
}