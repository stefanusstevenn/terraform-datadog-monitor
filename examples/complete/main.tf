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
  evaluation_delay    = "300"

  recipients         = ["bei@traveloka.com"]
  alert_recipients   = ["pagerduty-bei"]
  warning_recipients = ["slack-bei-alert"]
  renotify_interval  = 0
  notify_audit       = false

  message            = "Monitor is triggered"
  escalation_message = "Monitor isn't resolved for given interval"

  tags         = ["tag1:tag1", "tag2:tag2"]
  timeboard_id = "823233"
}
