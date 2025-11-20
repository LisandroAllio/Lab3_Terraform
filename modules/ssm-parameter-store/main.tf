resource "aws_ssm_parameter" "parameter_front_host" {
  name  = "DB-HOST"
  type  = "String"
  value = "database.cluster-namespace" #Debería modificarlo creando las variables
}

resource "aws_ssm_parameter" "parameter_bd_..." {
    name = ""
    type = ""
}