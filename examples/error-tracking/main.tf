locals {
  product_domain = "BEI"
  service        = "boot-camp"
  environment    = "dev"

  thresholds = {
    critical = 1
  }
}

module "datadog_log_error_tracking" {
  source         = "../../"
  product_domain = local.product_domain
  service        = local.service
  environment    = local.environment

  name             = "${local.product_domain} - ${local.environment} - Error {{ log.attributes.[error.kind] }} occurred in ${local.service}"
  type             = "error-tracking alert"
  query            = "error-tracking-logs(\"service:${local.service} issue.age:<=86400000\").index(\"*\").rollup(\"count\").by(\"issue.id\").last(\"1d\") >= 1"
  
  thresholds       = local.thresholds

  alert_recipients   = ["slack-traveloka-backend-infra-testing"]
  include_tags       = false
}

