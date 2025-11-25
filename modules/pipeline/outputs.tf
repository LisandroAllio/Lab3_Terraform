output "pipeline_name" {
  description = "Name of the CodePipeline"
  value       = aws_codepipeline.codepipeline.name
}

output "pipeline_arn" {
  description = "ARN of the CodePipeline"
  value       = aws_codepipeline.codepipeline.arn
}

output "s3_bucket_name" {
  description = "Name of the S3 bucket for pipeline artifacts"
  value       = aws_s3_bucket.codepipeline_bucket.bucket
}

output "codepipeline_role_arn" {
  description = "ARN of the CodePipeline IAM role"
  value       = aws_iam_role.codepipeline_role.arn
}

output "github_connection_arn" {
  description = "ARN of the GitHub CodeStar connection"
  value       = aws_codestarconnections_connection.git_connection.arn
}

output "github_connection_status" {
  description = "Status of the GitHub CodeStar connection"
  value       = aws_codestarconnections_connection.git_connection.connection_status
}