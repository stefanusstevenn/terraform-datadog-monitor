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

  name       = "${local.product_domain} - ${local.cluster} - ${local.environment} - CPU Usage is High on IP: {{ host.ip }} Name: {{ host.name }}"
  query      = "avg(last_5m):100 - avg:system.cpu.idle{cluster:${local.cluster}, environment:${local.environment}} by {host} >= ${local.thresholds["critical"]}"
  thresholds = local.thresholds

  recipients = ["slack-bei", "pagerduty-bei", "bei@traveloka.com"]
}

