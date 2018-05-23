locals {
  message = "${var.message}${length(var.recipients) > 0 ? " @" : ""}${join(" @", var.recipients)}"
  tags    = ["environment:${var.environment}", "product_domain:${var.product_domain}", "service:${var.service}"]
}

resource "datadog_monitor" "template" {
  count = "${var.enabled}"

  name               = "${var.name}"
  type               = "metric alert"
  message            = "${local.message}"
  escalation_message = "${var.escalation_message}"

  query = "${var.query}"

  thresholds = "${var.thresholds}"

  renotify_interval = "${var.renotify_interval}"
  notify_audit      = "${var.notify_audit}"

  tags = "${concat(local.tags, var.tags)}"
}
