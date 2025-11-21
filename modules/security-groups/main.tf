resource "aws_security_group" "alb" {
  name        = "${var.name_prefix}-alb-sg"
  description = "Security group para el ALB"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP desde internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS desde internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Salida total"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    {
      Name        = "${var.name_prefix}-alb-sg"
      Environment = var.environment
      ManagedBy   = "Terraform"
    },
    var.tags
  )
}

resource "aws_security_group" "ecs_tasks" {
  name        = "${var.name_prefix}-ecs-tasks-sg"
  description = "Security group para las ECS tasks frontend"
  vpc_id      = var.vpc_id

  egress {
    description = "Salida total"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    {
      Name        = "${var.name_prefix}-ecs-tasks-sg"
      Environment = var.environment
      ManagedBy   = "Terraform"
    },
    var.tags
  )
}

resource "aws_security_group" "mysql" {
  name        = "${var.name_prefix}-mysql-sg"
  description = "Security group para la base de datos MySQL"
  vpc_id      = var.vpc_id

  egress {
    description = "Salida total"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    {
      Name        = "${var.name_prefix}-mysql-sg"
      Environment = var.environment
      ManagedBy   = "Terraform"
    },
    var.tags
  )
}

resource "aws_security_group" "mysql_efs" {
  name        = "${var.name_prefix}-mysql-efs-sg"
  description = "Security group para EFS asociado a MySQL"
  vpc_id      = var.vpc_id

  egress {
    description = "Salida total"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    {
      Name        = "${var.name_prefix}-mysql-efs-sg"
      Environment = var.environment
      ManagedBy   = "Terraform"
    },
    var.tags
  )
}

resource "aws_security_group" "cluster" {
  name        = "${var.name_prefix}-cluster-sg"
  description = "Security group para las instancias del cluster ECS"
  vpc_id      = var.vpc_id

  egress {
    description = "Salida total"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    {
      Name        = "${var.name_prefix}-cluster-sg"
      Environment = var.environment
      ManagedBy   = "Terraform"
    },
    var.tags
  )
}

resource "aws_security_group_rule" "ecs_ingress_from_alb" {
  description              = "HTTP desde el ALB hacia las ECS tasks"
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.ecs_tasks.id
  source_security_group_id = aws_security_group.alb.id
}

resource "aws_security_group_rule" "ecs_egress_to_mysql" {
  description              = "MySQL hacia el security group de la base de datos"
  type                     = "egress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  security_group_id        = aws_security_group.ecs_tasks.id
  source_security_group_id = aws_security_group.mysql.id
}

resource "aws_security_group_rule" "mysql_ingress_from_ecs" {
  description              = "Acceso MySQL desde las ECS tasks"
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  security_group_id        = aws_security_group.mysql.id
  source_security_group_id = aws_security_group.ecs_tasks.id
}

resource "aws_security_group_rule" "efs_ingress_from_mysql" {
  description              = "EFS permite trafico NFS desde MySQL"
  type                     = "ingress"
  from_port                = 2049
  to_port                  = 2049
  protocol                 = "tcp"
  security_group_id        = aws_security_group.mysql_efs.id
  source_security_group_id = aws_security_group.mysql.id
}

resource "aws_security_group_rule" "cluster_ingress_http_from_alb" {
  description              = "HTTP desde el ALB hacia las instancias del cluster"
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.cluster.id
  source_security_group_id = aws_security_group.alb.id
}

resource "aws_security_group_rule" "cluster_ingress_https_from_alb" {
  description              = "HTTPS desde el ALB hacia las instancias del cluster"
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.cluster.id
  source_security_group_id = aws_security_group.alb.id
}


