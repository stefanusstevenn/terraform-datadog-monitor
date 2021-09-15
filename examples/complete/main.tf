locals {
  product_domain = "BEI"
  service        = "beical"
  environment    = "production"
  cluster        = "beical-app"

  thresholds = {
    critical = 80
    warning  = 70
  }
}

module "system_monitor_cpu_usage" {
  source         = "../../"
  product_domain = local.product_domain
  service        = local.service
  environment    = local.environment

  name             = "${local.product_domain} - ${local.cluster} - ${local.environment} - CPU Usage is High on IP: {{ host.ip }} Name: {{ host.name }}"
  query            = "avg(last_5m):100 - avg:system.cpu.idle{cluster:${local.cluster}, environment:${local.environment}} by {host} >= ${local.thresholds["critical"]}"
  thresholds       = local.thresholds
  evaluation_delay = "300"

  recipients         = ["bei@traveloka.com"]
  alert_recipients   = ["pagerduty-bei"]
  warning_recipients = ["slack-bei-alert"]
  renotify_interval  = 0
  notify_audit       = false
  include_tags       = true

  message            = "Monitor is triggered"
  escalation_message = "Monitor isn't resolved for given interval"

  tags         = ["tag1:tag1", "tag2:tag2"]
  timeboard_id = "823233"
}

