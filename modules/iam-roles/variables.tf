# EC2 instance role for ECS cluster
variable "instance_profile_name" {
  description = "Name of the IAM instance profile"
  type        = string
}

variable "instance_role_name" {
  description = "Name of the IAM instance role"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

#Task Execution role policy name variable
variable "task_execution_role_name" {
  description = "Name of the task execution role"
  type        = string
}

#Parameter Store custom policy name variable
variable "parameter_store_role_name" {
  description = "Name of the custom parameter store role"
  type        = string
}
