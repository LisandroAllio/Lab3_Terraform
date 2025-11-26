### CONNECTION GITHUB ### 
resource "aws_codestarconnections_connection" "git_connection" {
    name = var.github_connection_name
    provider_type = "GitHub"
}

### BUCKET S3 ###
resource "aws_s3_bucket" "codepipeline_bucket" {
  bucket = var.s3_bucket_name
}

resource "aws_s3_bucket_public_access_block" "codepipeline_bucket_pab" {
  bucket = aws_s3_bucket.codepipeline_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

### PIPELINE STAGES ###
resource "aws_codepipeline" "codepipeline" {
    name           = "lab-front-pipeline"
    pipeline_type  = "V2"
    execution_mode = "QUEUED"
    role_arn       = aws_iam_role.codepipeline_role.arn
    artifact_store {
        location = aws_s3_bucket.codepipeline_bucket.bucket 
        type     = "S3"  
    }
    stage {
        name = "Source"
        action {
            name             = "Source"
            category         = "Source"
            owner            = "AWS"
            provider         = "CodeStarSourceConnection"
            version          = "1"
            output_artifacts = ["source_output"]

            configuration = {
                ConnectionArn    = aws_codestarconnections_connection.git_connection.arn
                FullRepositoryId = var.repository_id
                BranchName       = "main"
            }
        }
    }
    stage {
        name = "Build"

        action {
            name             = "Build"
            category         = "Build"
            owner            = "AWS"
            region           = var.aws_region
            provider         = "CodeBuild"
            input_artifacts  = ["source_output"]
            output_artifacts = ["build_output"]
            version          = "1"

            configuration = {
                ProjectName = var.codebuild_project_name
            }
        }
    }

    stage {
        name = "Deploy"

        action {
            name            = "Deploy"
            category        = "Deploy"
            owner           = "AWS"
            provider        = "ECS"
            input_artifacts = ["build_output"]
            version         = "1"

            configuration = {
                ClusterName = var.ecs_cluster_name
                ServiceName = var.ecs_service_name
                FileName    = "imagedefinitions.json"
            }
        }
    }

    trigger {
      provider_type = "CodeStarSourceConnection"
      git_configuration {
        source_action_name = "Source"
        push {
            branches {
                includes = ["main"]
            }
        }
      }
    }
}

/*
# Notificaciones SNS para el estado del pipeline (CodePipeline V2)
resource "aws_codepipeline_notification_rule" "pipeline_notifications" {
  count = var.sns_topic_arn != null ? 1 : 0

  name       = "${aws_codepipeline.codepipeline.name}-notifications"
  pipeline_arn = aws_codepipeline.codepipeline.arn
  target {
    sns_topic_arn = var.sns_topic_arn
    type          = "SNS"
  }

  event_type_ids = [
    "codepipeline-pipeline-pipeline-execution-started",    # Cuando inicia el pipeline
    "codepipeline-pipeline-pipeline-execution-succeeded",  # Cuando termina exitosamente
    "codepipeline-pipeline-pipeline-execution-failed",     # Cuando falla
    "codepipeline-pipeline-pipeline-execution-canceled",   # Cuando se cancela
    "codepipeline-pipeline-stage-execution-failed",
    "codepipeline-pipeline-stage-execution-succeeded",
    "codepipeline-pipeline-action-execution-failed",
    "codepipeline-pipeline-action-execution-succeeded"
  ]
}
*/
