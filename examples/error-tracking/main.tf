locals {
  product_domain = "BEI"
  service        = "boot-camp"
  environment    = "dev"

  thresholds = {
    critical = 1
  }

  condition           = "count"
  evaluate_query_time = "1d"

  name = {
    "count"     = "${local.product_domain} - ${local.environment} - Error \"{{ log.attributes.[error.kind] }}\" occurred in ${local.service}",
    "new issue" = "${local.product_domain} - ${local.environment} - Error \"{{ log.attributes.[error.kind] }}\" first time occurred in ${local.service}"
  }

  query = {
    "count"     = "error-tracking-logs(\"service:${local.service}\").index(\"*\").rollup(\"count\").by(\"issue.id\").last(\"${local.evaluation_query}\") >= 1",
    "new issue" = "error-tracking-logs(\"service:${local.service} issue.age:<=300000\").index(\"*\").rollup(\"count\").by(\"issue.id\").last(\"5m\") >= 1"
  }
}

module "datadog_log_error_tracking" {
  source         = "../../"
  product_domain = local.product_domain
  service        = local.service
  environment    = local.environment

  name             = local.name[local.condition]
  type             = "error-tracking alert"
  query            = local.query[local.condition]
  
  thresholds       = local.thresholds

  alert_recipients   = ["slack-traveloka-datadog-error-tracking-test"]
  include_tags       = false
}

