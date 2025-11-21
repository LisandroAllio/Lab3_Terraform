module "parameter_store" {
  source = "terraform-aws-modules/ssm-parameter/aws"

  name  = "lab3/DB_HOST"
  value = "${module.service_discovery.service_name}.${module.service_discovery.namespace_name}"
  secure_type = true
  tags  = {
    Name        = "Parameter Store"
    Environment = "dev"
    Owner       = "Lara"
  }
}