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

variable "monitor_names" {
  type        = "list"
  description = "List of monitor names"
}

variable "monitor_queries" {
  type        = "list"
  description = "List of monitor queries"
}

variable "critical_thresholds" {
  type        = "list"
  description = "List of critical thresholds for these monitorings"
}

variable "warning_thresholds" {
  type        = "list"
  description = "List of warning thresholds for these monitorings"
}

variable "evaluation_delay" {
  type        = "string"
  default     = "0"
  description = "Time to delay evaluation in seconds"
}

variable "tags" {
  type        = "list"
  default     = []
  description = "Additional tags for this monitor"
}

variable "timeboard_id" {
  type        = "string"
  default     = ""
  description = "The timeboard id for this monitor"
}

variable "recipients" {
  type        = "list"
  default     = []
  description = "Notification recipients when both alert and warning are triggered"
}

variable "alert_recipients" {
  type        = "list"
  default     = []
  description = "Notification recipients when only alert is triggered"
}

variable "warning_recipients" {
  type        = "list"
  default     = []
  description = "Notification recipients when only warning is triggered"
}

variable "message" {
  type        = "string"
  default     = ""
  description = "The message when monitor triggered"
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
