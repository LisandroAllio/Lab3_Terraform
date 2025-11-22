import {
  to = aws_codestarconnections_connection.git_connection
  identity = {
    "arn" = "arn:aws:codeconnections:us-east-1:979244568430:connection/4559c724-bd4c-4af9-929b-8d1448d57c7b"
  }
} #Traje la conexión que Eze ya tenia creada, es más practico que andar haciendo una nueva.

resource "aws_codestarconnections_connection" "git_connection" {
    name = "github-conn-eze-final"
    provider_type = "GitHub"
}

resource "aws_codepipeline" "codepipeline" {
    name           = "lab3-pipeline"
    pipeline_type  = "V1"
    execution_mode = "QUEUED"
    role_arn       = "" #aws_iam_role.codepipeline_role.arn - Se podría buscar un rol para pipeline que Eze ya tenga creado e importarlo/copiarlo
    artifact_store {
        location = "" #aws_s3_bucket.codepipeline_bucket.bucket - Hay que crear si o si un bucket, con sus permisos y demás.
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
                FullRepositoryId = "LisandroAllio/Lab3_Terraform"
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
            region           = "us-east-1"
            provider         = "CodeBuild"
            input_artifacts  = ["source_output"]
            output_artifacts = ["build_output"]
            version          = "1"

            configuration = {
                ProjectName = "" # aws_codebuild_project.nombre_recurso.name 
            }
        }
    }

    # Falta el stage Deploy.

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
    } #Esto es lo que permite activar el pipeline con un push.
}
