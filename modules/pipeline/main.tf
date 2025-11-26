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


### ROLES PIPELINE ###
resource "aws_iam_role" "codepipeline_role" {
  name = var.codepipeline_role_name

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
      "s3:PutObjectAcl",
      "s3:PutObject",
      "s3:GetObjectVersion",
      "s3:GetObject",
      "s3:GetBucketVersioning"
    ]
    resources = [
      aws_s3_bucket.codepipeline_bucket.arn,
      "${aws_s3_bucket.codepipeline_bucket.arn}/*"
    ]
  }

  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]
    resources = ["arn:aws:iam::${var.aws_account_id}:role/codepipeline-ecs-deploy-role"]
  }

  statement {
    effect = "Allow"
    actions = ["codestar-connections:UseConnection"]
    resources = [aws_codestarconnections_connection.git_connection.arn]
  }

  statement {
    effect = "Allow"
    actions = [
      "codebuild:StartBuild",
      "codebuild:BatchGetBuilds"
    ]
    resources = ["arn:aws:codebuild:${var.aws_region}:${var.aws_account_id}:project/*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "ecs:UpdateService",
      "ecs:DescribeServices",
      "ecs:DescribeClusters",
      "ecs:CreateService",
      "ecs:ListTasks",
      "ecs:DescribeTasks",
      "ecs:ListServices",
      "ecs:RegisterTaskDefinition",
      "ecs:DescribeTaskDefinition",
      "ecs:ListTaskDefinitions",
      "ecs:DeregisterTaskDefinition",
      "ecs:TagResource"
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "servicediscovery:CreateService",
      "servicediscovery:GetService",
      "servicediscovery:UpdateService",
      "servicediscovery:DeleteService",
      "servicediscovery:RegisterInstance",
      "servicediscovery:DeregisterInstance",
      "servicediscovery:DiscoverInstances",
      "servicediscovery:GetInstancesHealthStatus",
      "servicediscovery:ListServices",
      "servicediscovery:ListInstances"
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "route53:GetHostedZone",
      "route53:ListHostedZonesByName",
      "route53:CreateHostedZone",
      "route53:ChangeResourceRecordSets",
      "route53:GetChange"
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = ["ecr:GetAuthorizationToken"]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability"
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
      "logs:PutLogEvents",
      "logs:CreateLogStream",
      "logs:CreateLogGroup"
    ]
    resources = ["arn:aws:logs:${var.aws_region}:${var.aws_account_id}:*"]
  }

  statement {
    effect = "Allow"
    actions = ["iam:PassRole"]
    resources = ["*"]
    condition {
      test     = "StringLike"
      variable = "iam:PassedToService"
      values = [
        "ecs-tasks.amazonaws.com",
        "ecs.amazonaws.com"
      ]
    }
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
