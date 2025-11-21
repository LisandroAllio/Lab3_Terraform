module "parameter_store" {
  source  = "terraform-aws-modules/ssm-parameter/aws"

  name  = "DB_HOST"
  value = "${module.service_discovery.service_name}.${module.service_discovery.namespace_name}"
}