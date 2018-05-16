terraform-datadog-monitor
=================

Terraform module for Datadog Monitor.



Usage
-----

```hcl
locals {
  product_domain = "BEI"
  service        = "beical"
  cluster        = "beical-app"
}

module "monitor_system_beical-app" {
  source          = "github.com/traveloka/terraform-datadog-monitor.git?ref=0.1.2"

  product_domain = "${local.product_domain}"
  service        = "${local.service}"

  name  = "${local.product_domain} - ${local.cluster} - CPU Usage is High on IP: {{ host.ip }} Name: {{ host.name }}"
  query = "avg(last_5m):100 - avg:system.cpu.idle{cluster:${local.cluster}} by {host}"

  thresholds = {
    critical = 80
    warning  = 70
  }

  message = "Monitor is triggered"

  recipients = ["slack-bei", "pagerduty-bei", "bei@traveloka.com"]
}
```

Terraform Version
-----------------

This module was created using Terraform 0.11.7. 
So to be more safe, Terraform version 0.11.7 or newer is required to use this module.

Authors
-------

* [Karsten Ari Agathon](https://github.com/karstenaa)

License
-------

Apache 2 Licensed. See LICENSE for full details.
