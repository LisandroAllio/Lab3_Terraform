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