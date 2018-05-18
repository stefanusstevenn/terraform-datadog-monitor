locals {
  product_domain = "BEI"
  service        = "beical"
  cluster        = "beical-app"
}

module "beical_app_monitor_system_cpu_idle" {
  source         = "../../"
  product_domain = "${local.product_domain}"
  service        = "${local.service}"

  name  = "${local.product_domain} - ${local.cluster} - CPU Usage is High on IP: {{ host.ip }} Name: {{ host.name }}"
  query = "avg(last_5m):100 - avg:system.cpu.idle{cluster:${local.cluster}} by {host}"

  thresholds = {
    critical = 80
    warning  = 70
  }

  recipients = ["slack-bei", "pagerduty-bei", "bei@traveloka.com"]
}
