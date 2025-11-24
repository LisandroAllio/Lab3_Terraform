
### CONEXION GITHUB ###
import {
  to = aws_codestarconnections_connection.git_connection
  identity = {
    "arn" = "arn:aws:codeconnections:${var.aws_region}:${var.aws_account_id}:connection/4559c724-bd4c-4af9-929b-8d1448d57c7b"
  }
} #Traje la conexión que Eze ya tenia creada, es más practico que andar haciendo una nueva.

resource "aws_codestarconnections_connection" "git_connection" {
    name = "github-conn-eze-final"
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


### ROLES PIPELINE ###
resource "aws_iam_role" "codepipeline_role" {
  name = "lab-front-pipeline-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "codepipeline.amazonaws.com"
        }
      }
    ]
  })
}

data "aws_iam_policy_document" "codepipeline_policy" {
  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:GetBucketVersioning",
      "s3:PutObjectAcl",
      "s3:PutObject"
    ]
    resources = [
      aws_s3_bucket.codepipeline_bucket.arn,
      "${aws_s3_bucket.codepipeline_bucket.arn}/*"
    ]
  }

  statement {
    effect = "Allow"
    actions = ["codestar-connections:UseConnection"]
    resources = [aws_codestarconnections_connection.git_connection.arn]
  }

  statement {
    effect = "Allow"
    actions = [
      "codebuild:BatchGetBuilds",
      "codebuild:StartBuild"
    ]
    resources = ["arn:aws:codebuild:${var.aws_region}:${var.aws_account_id}:project/*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "ecs:UpdateService",
      "ecs:DescribeServices"
    ]
    resources = [
      "arn:aws:ecs:${var.aws_region}:${var.aws_account_id}:cluster/${var.ecs_cluster_name}",
      "arn:aws:ecs:${var.aws_region}:${var.aws_account_id}:service/${var.ecs_cluster_name}/*"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "ecs:DescribeTaskDefinition",
      "ecs:RegisterTaskDefinition"
    ]
    resources = ["arn:aws:ecs:${var.aws_region}:${var.aws_account_id}:task-definition/*"]
  }

  statement {
    effect = "Allow"
    actions = ["ecr:GetAuthorizationToken"]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage"
    ]
    resources = ["arn:aws:ecr:${var.aws_region}:${var.aws_account_id}:repository/*"]
  }

  statement {
    effect = "Allow"
    actions = ["sns:Publish"]
    resources = ["arn:aws:sns:${var.aws_region}:${var.aws_account_id}:*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["arn:aws:logs:${var.aws_region}:${var.aws_account_id}:*"]
  }
}

resource "aws_iam_role_policy" "codepipeline_policy" {
  name = "codepipeline_policy"
  role = aws_iam_role.codepipeline_role.id
  policy = data.aws_iam_policy_document.codepipeline_policy.json
}

### PIPELINE STAGES ###
resource "aws_codepipeline" "codepipeline" {
    name           = "lab-front-pipeline"
    pipeline_type  = "V1"
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
