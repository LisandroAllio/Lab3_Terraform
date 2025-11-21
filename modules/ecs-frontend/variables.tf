variable "service_name" {
  description = "Name of the ECS service"
  type        = string
}

variable "cluster_id" {
  description = "ID of the ECS cluster"
  type        = string
}

variable "task_definition_arn" {
  description = "ARN of the task definition"
  type        = string
}

variable "desired_count" {
  description = "Number of desired tasks"
  type        = number
  default     = 2
}

variable "subnet_ids" {
  description = "List of subnet IDs for the service"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs"
  type        = list(string)
}

variable "target_group_arn" {
  description = "ARN of the target group for load balancer"
  type        = string
}

variable "container_name" {
  description = "Name of the container in the task definition"
  type        = string
  default     = "frontend"
}

variable "container_port" {
  description = "Port of the container"
  type        = number
  default     = 80
}

variable "dependencies" {
  description = "List of resources this service depends on"
  type        = list(any)
  default     = []
}

variable "tags" {
  description = "Tags to apply to the service"
  type        = map(string)
  default     = {}
}