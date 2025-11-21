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

# Cluster - Solo ALB puede conectarse
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


# Frontend Tasks - Solo ALB puede conectarse
resource "aws_security_group" "task_front" {
  name        = "${var.name_prefix}-front-sg"
  description = "Security group para las ECS tasks frontend"
  vpc_id      = var.vpc_id

  # Outbound: All traffic
  egress {
    description = "Salida total"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    {
      Name        = "${var.name_prefix}-front-sg"
      Environment = var.environment
      ManagedBy   = "Terraform"
    },
    var.tags
  )
}

# MySQL Tasks - Solo frontend y EFS pueden comunicarse
resource "aws_security_group" "task_mysql" {
  name        = "${var.name_prefix}-mysql-sg"
  description = "Security group para la base de datos MySQL"
  vpc_id      = var.vpc_id

  tags = merge(
    {
      Name        = "${var.name_prefix}-mysql-sg"
      Environment = var.environment
      ManagedBy   = "Terraform"
    },
    var.tags
  )
}

# EFS - Solo la base de datos puede comunicarse
resource "aws_security_group" "efs" {
  name        = "${var.name_prefix}-efs-sg"
  description = "Security group para EFS asociado a MySQL"
  vpc_id      = var.vpc_id

  tags = merge(
    {
      Name        = "${var.name_prefix}-efs-sg"
      Environment = var.environment
      ManagedBy   = "Terraform"
    },
    var.tags
  )
}

# CLUSTER RULES
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

# FRONTEND RULES
# Inbound: HTTP (80) desde SG del ALB
resource "aws_security_group_rule" "front_ingress_from_alb" {
  description              = "HTTP desde el ALB hacia las ECS tasks frontend"
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.task_front.id
  source_security_group_id = aws_security_group.alb.id
}

# Outbound: MySQL (3306) al SG del MSQL
resource "aws_security_group_rule" "mysql_egress_to_front" {
  description              = "frontend hacia las MySQL"
  type                     = "egress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  security_group_id        = aws_security_group.task_front.id
  source_security_group_id = aws_security_group.task_mysql.id
}

# MYSQL RULES
# Inbound: MySQL (3306) desde SG del Frontend
resource "aws_security_group_rule" "mysql_ingress_from_front" {
  description              = "MySQL desde las ECS tasks frontend"
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  security_group_id        = aws_security_group.task_mysql.id
  source_security_group_id = aws_security_group.task_front.id
}

# Outbound: NFS (2049) hacia SG de la EFS
resource "aws_security_group_rule" "mysql_egress_to_efs" {
  description              = "NFS hacia EFS desde MySQL"
  type                     = "egress"
  from_port                = 2049
  to_port                  = 2049
  protocol                 = "tcp"
  security_group_id        = aws_security_group.task_mysql.id
  source_security_group_id = aws_security_group.efs.id
}

# EFS RULES
# Inbound: NFS (2049) desde SG de la BD
resource "aws_security_group_rule" "efs_ingress_from_mysql" {
  description              = "NFS desde MySQL hacia EFS"
  type                     = "ingress"
  from_port                = 2049
  to_port                  = 2049
  protocol                 = "tcp"
  security_group_id        = aws_security_group.efs.id
  source_security_group_id = aws_security_group.task_mysql.id
}



