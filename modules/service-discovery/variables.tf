variable "namespace_name" {
  description = "Name of the service discovery namespace"
  type        = string
}

variable "namespace_description" {
  description = "Description of the service discovery namespace"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for the namespace"
  type        = string
}

variable "service_name" {
  description = "Name of the service discovery service"
  type        = string
}

variable "dns_ttl" {
  description = "TTL for DNS records"
  type        = number
  default     = 10
}

variable "dns_type" {
  description = "Type of DNS record"
  type        = string
  default     = "A"
}

variable "routing_policy" {
  description = "Routing policy for DNS"
  type        = string
  default     = "MULTIVALUE"
}

variable "failure_threshold" {
  description = "Health check failure threshold"
  type        = number
  default     = 1
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}