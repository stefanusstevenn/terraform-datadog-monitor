variable "product_domain" {
  type        = "string"
  description = "The name of the product domain"
}

variable "service" {
  type        = "string"
  description = "The name of the service"
}

variable "environment" {
  type        = "string"
  description = "The name of the environment"
}

variable "name" {
  type        = "string"
  description = "The name for monitor"
}

variable "query" {
  type        = "string"
  description = "The query for monitor"
}

variable "message" {
  type        = "string"
  default     = ""
  description = "The message when monitor triggered"
}

variable "recipients" {
  type        = "list"
  description = "Notification recipients when monitor triggered"
}

variable "escalation_message" {
  type        = "string"
  default     = ""
  description = "The escalation message when monitor isn't resolved for given time"
}

variable "renotify_interval" {
  type        = "string"
  default     = "0"
  description = "Time interval in minutes which escalation_message will be sent when monitor is triggered"
}

variable "notify_audit" {
  type        = "string"
  default     = false
  description = "Whether any configuration changes should be notified"
}

variable "thresholds" {
  type        = "map"
  description = "The warning and critical thresholds for this monitoring"
}

variable "tags" {
  type        = "list"
  default     = []
  description = "Additional tags for this monitor"
}

variable "enabled" {
  type        = "string"
  default     = true
  description = "To enable this module"
}
