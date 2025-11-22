# IAM Role for CodeBuild
resource "aws_iam_role" "codebuild" {
  name = var.codebuild_iam_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "codebuild.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name        = "CodeBuild Role"
    Environment = "dev"
    Owner       = "federico"
  }
}

# Basic permissions for CodeBuild
resource "aws_iam_role_policy" "codebuild" {
  name = var.codebuild_iam_role_policy_name
  role = aws_iam_role.codebuild.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "ecr:GetAuthorizationToken"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:PutImage",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload"
        ]
        Resource = "arn:aws:ecr:us-east-1:979244568430:repository/*"
      }
    ]
  })
}

# CodeBuild Project
resource "aws_codebuild_project" "frontend" {
  name         = var.codebuild_project_name
  description  = "Build project for frontend application"
  service_role = aws_iam_role.codebuild.arn

  artifacts {
    type = "NO_ARTIFACTS"  # Change if you need artifacts stored
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:4.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true  # Required for Docker builds

    environment_variable {
      name  = "ENV"
      value = "dev"
    }
  }

  source {
    type            = "GITHUB"
    location        = "https://github.com/federicogfb/teralab2.git"
    git_clone_depth = 1
    buildspec       = "buildspec.yml"  # Or inline with buildspec = <<-EOF ... EOF
  }

  tags = {
    Name        = "Frontend Build"
    Environment = "dev"
    Owner       = "federico"
  }
}