variable "cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
}

variable "container_insights" {
  description = "Enable container insights"
  type        = string
  default     = "enabled"
}

variable "capacity_provider_name" {
  description = "Name of the capacity provider"
  type        = string
}

variable "asg_arn" {
  description = "ARN of the Auto Scaling Group"
  type        = string
}

variable "managed_termination_protection" {
  description = "Managed termination protection setting"
  type        = string
  default     = "ENABLED"
}

variable "managed_scaling_status" {
  description = "Managed scaling status"
  type        = string
  default     = "ENABLED"
}

variable "target_capacity" {
  description = "Target capacity percentage"
  type        = number
  default     = 100
}

variable "minimum_scaling_step_size" {
  description = "Minimum scaling step size"
  type        = number
  default     = 1
}

variable "maximum_scaling_step_size" {
  description = "Maximum scaling step size"
  type        = number
  default     = 10
}

variable "capacity_provider_base" {
  description = "Base capacity for capacity provider"
  type        = number
  default     = 1
}

variable "capacity_provider_weight" {
  description = "Weight for capacity provider"
  type        = number
  default     = 100
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}