locals {
  product_domain = "BEI"
  service        = "beical"
  environment    = "production"
  cluster        = "beical-app"

  critical_thresholds = [80]
  warning_thresholds  = [70]
}

module "system_monitor_cpu_usage" {
  source         = "../../"
  product_domain = "${local.product_domain}"
  service        = "${local.service}"
  environment    = "${local.environment}"

  monitor_names       = ["${local.product_domain} - ${local.cluster} - ${local.environment} - CPU Usage is High on IP: {{ host.ip }} Name: {{ host.name }}"]
  monitor_queries     = "${formatlist("avg(last_5m):100 - avg:system.cpu.idle{cluster:%s, environment:%s} by {host} >= %s", local.cluster, local.environment, local.critical_thresholds)}"
  critical_thresholds = "${local.critical_thresholds}"
  warning_thresholds  = "${local.warning_thresholds}"

  recipients = ["slack-bei", "pagerduty-bei", "bei@traveloka.com"]
}
