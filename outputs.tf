output "name" {
  value       = "${join(",", datadog_monitor.template.*.name)}"
  description = "The name of datadog monitor"
}
