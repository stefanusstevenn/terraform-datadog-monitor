locals {
  message = "${var.message}${length(var.recipients) > 0 ? " @" : ""}${join(" @", var.recipients)}"
}

resource "datadog_monitor" "template" {
  count = "${var.enabled}"

  name               = "${var.name}"
  type               = "metric alert"
  message            = "${local.message}"
  escalation_message = "${var.escalation_message}"

  query = "${var.query} ${var.comparison != "" ? var.comparison : var.thresholds["critical"] >= lookup(var.thresholds, "warning", -999) ? ">=" : "<="} ${var.thresholds["critical"]}"

  thresholds = "${var.thresholds}"

  renotify_interval = "${var.renotify_interval}"
  notify_audit      = "${var.notify_audit}"

  tags = ["product_domain:${var.product_domain}", "service:${var.service}"]
}
