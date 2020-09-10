
variable "create_ssl" {
  description = "Bool to create ssl cert and nginx proxy"
  type        = bool
  default     = true
}

locals {
  create_ssl = var.domain_name == "" ? false : var.create_ssl
  fqdn       = var.domain_name != "" && var.hostname != "" ? "${var.hostname}.${var.domain_name}" : ""
}

data "aws_route53_zone" "this" {
  count = var.domain_name != "" && local.create_ssl ? 1 : 0
  name  = var.domain_name
}

resource "aws_route53_record" "this" {
  count = var.domain_name != "" && var.hostname != "" && local.create_ssl ? 1 : 0

  name    = "${var.hostname}.${var.domain_name}"
  type    = "A"
  ttl     = "300"
  zone_id = join("", data.aws_route53_zone.this.*.id)
  records = [join("", aws_eip.this.*.public_ip)]
}
