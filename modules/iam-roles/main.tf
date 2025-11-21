# IAM Instance Profile for EC2 instances
resource "aws_iam_instance_profile" "ecs_instance" {
  name = var.instance_profile_name
  role = aws_iam_role.ecs_instance.name
}

resource "aws_iam_role" "ecs_instance" {
  name = var.instance_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  #tags = var.tags --> operation error IAM: CreateRole, user is not authorized to perform: iam:TagRole on resource
}

resource "aws_iam_role_policy_attachment" "ecs_instance" {
  role       = aws_iam_role.ecs_instance.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

# IAM Execution Role for ECS Task Definition
resource "aws_iam_role" "ecs_task_execution" {
  name =  var.task_execution_role_name      #"ecs-task-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })

  # tags removed due to IAM tagging restrictions
}

# Attach the default ECS Task Execution policy (for ECR, CloudWatch Logs)
resource "aws_iam_role_policy_attachment" "ecs_task_execution" {
  role       = aws_iam_role.ecs_task_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

#Data source to bring default KMS aws managed key 
data "aws_kms_key" "ssm" {
  key_id = "alias/aws/ssm"
}

# Custom policy for Parameter Store access
resource "aws_iam_policy" "parameter_store_read" {
  name        = var.parameter_store_role_name     #"ecs-parameter-store-read"
  description = "Allow ECS tasks to read from Parameter Store (and SecureString)"

  lifecycle {
    prevent_destroy = true
  }

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ssm:GetParameters",
          "ssm:GetParameter",
          "ssm:GetParametersByPath"
        ]
        Resource = "arn:aws:ssm:*:*:parameter/*"  # Narrow this down for production
      },
      {
        Effect = "Allow"
        Action = [
          "kms:Decrypt"
        ]
        Resource = data.aws_kms_key.ssm.arn
      }
    ]
  })
  # tags removed due to IAM tagging restrictions
}

# Attach Parameter Store policy to the execution role
resource "aws_iam_role_policy_attachment" "parameter_store" {
  role       = aws_iam_role.ecs_task_execution.name
  policy_arn = aws_iam_policy.parameter_store_read.arn
}