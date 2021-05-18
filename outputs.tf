output "name" {
  value       = "${join(",", datadog_monitor.template.*.name)}"
  description = "The name of datadog monitor"
}

output "monitor_id" {
  value       = "${datadog_monitor.template.*.id}"
  description = "The id(s) of datadog monitor created"
}
