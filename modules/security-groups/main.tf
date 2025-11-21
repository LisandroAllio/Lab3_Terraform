# ALB Security Group
resource "aws_security_group" "alb" {
  name        = local.sg_names.alb
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

  tags = merge(local.base_tags, { Name = local.sg_names.alb })
}

# Task Frontend
resource "aws_security_group" "front" {
  name        = local.sg_names.front
  description = "Security group para las tasks frontend"
  vpc_id      = var.vpc_id

  egress {
    description = "Salida total"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.base_tags, { Name = local.sg_names.front })
}

# MySQL Security Group
resource "aws_security_group" "mysql" {
  name        = local.sg_names.mysql
  description = "Security group para la base de datos MySQL"
  vpc_id      = var.vpc_id
  tags = merge(local.base_tags, { Name = local.sg_names.mysql })
}

# EFS Security Group
resource "aws_security_group" "mysql_efs" {
  name        = local.sg_names.efs
  description = "Security group para EFS asociado a MySQL"
  vpc_id      = var.vpc_id

  tags = merge(local.base_tags, { Name = local.sg_names.efs })
}

# Cluster Security Group
resource "aws_security_group" "cluster" {
  name        = local.sg_names.cluster
  description = "Security group para las instancias del cluster ECS"
  vpc_id      = var.vpc_id

  egress {
    description = "Salida total"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.base_tags, { Name = local.sg_names.cluster })
}

# SECURITY GROUP RULES
# Cluster - Ingress HTTP from ALB
resource "aws_security_group_rule" "cluster_ingress_http_from_alb" {
  description              = "HTTP desde el ALB hacia las instancias del cluster"
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.cluster.id
  source_security_group_id = aws_security_group.alb.id
}

# Task Front - Ingress from ALB
resource "aws_security_group_rule" "ecs_ingress_from_alb" {
  description              = "HTTP desde el ALB hacia las ECS tasks"
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.front.id
  source_security_group_id = aws_security_group.alb.id
}

# Task Front - Egress to Mysql
resource "aws_security_group_rule" "front_egress_to_mysql" {
  description              = "Egress desde Frontend hacia MySQL"
  type                     = "egress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  security_group_id        = aws_security_group.front.id
  source_security_group_id = aws_security_group.mysql.id
}

# Task MySQL - Ingress from Front
resource "aws_security_group_rule" "mysql_ingress_from_ecs" {
  description              = "Acceso MySQL desde las ECS tasks"
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  security_group_id        = aws_security_group.mysql.id
  source_security_group_id = aws_security_group.front.id
}

# Task MySQL - Egress to EFS 
resource "aws_security_group_rule" "mysql_egress_to_efs" {
  description              = "Egress desde MySQL hacia EFS"
  type                     = "egress"
  from_port                = 2049
  to_port                  = 2049
  protocol                 = "tcp"
  security_group_id        = aws_security_group.mysql.id
  source_security_group_id = aws_security_group.mysql_efs.id
}

# EFS - Ingress from MySQL
resource "aws_security_group_rule" "efs_ingress_from_mysql" {
  description              = "EFS permite trafico NFS desde MySQL"
  type                     = "ingress"
  from_port                = 2049
  to_port                  = 2049
  protocol                 = "tcp"
  security_group_id        = aws_security_group.mysql_efs.id
  source_security_group_id = aws_security_group.mysql.id
}