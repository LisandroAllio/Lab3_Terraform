variable "mysql_log_group_name" {
  description = "Name of the MySQL log group"
  type        = string
}

variable "frontend_log_group_name" {
  description = "Name of the frontend log group"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}