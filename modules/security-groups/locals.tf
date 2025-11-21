locals {
  sg_names = {
    alb     = "${var.name_prefix}-alb-sg"
    front     = "${var.name_prefix}-front-sg"
    mysql   = "${var.name_prefix}-mysql-sg"
    efs     = "${var.name_prefix}-mysql-efs-sg"
    cluster = "${var.name_prefix}-cluster-sg"
  }

  base_tags = merge(
    {
      Environment = var.environment
      ManagedBy   = "Terraform"
    },
    var.tags
  )
}
