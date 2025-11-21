variable "asg_name" {
  description = "Name of the Auto Scaling Group"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the ASG"
  type        = list(string)
}

variable "min_size" {
  description = "Minimum size of the ASG"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum size of the ASG"
  type        = number
  default     = 5
}

variable "desired_capacity" {
  description = "Desired capacity of the ASG"
  type        = number
  default     = 3
}

variable "instance_name" {
  description = "Name tag for EC2 instances"
  type        = string
}

variable "launch_template_prefix" {
  description = "Prefix for launch template name"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "iam_instance_profile_arn" {
  description = "ARN of the IAM instance profile"
  type        = string
}

variable "security_group_ids" {
  description = "List of security group IDs"
  type        = list(string)
}

variable "cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}