resource "aws_route53_record" "subdomain" {
  zone_id = var.route53_apex_zone_id
  name    = var.domain
  type    = "CNAME"
  ttl     = var.route53_default_ttl

  records = [
    aws_lb.app.dns_name,
  ]
}

resource "aws_route53_record" "alternative_domains" {
  for_each = { for domain in var.alternative_domains : domain => domain }

  zone_id = var.route53_apex_zone_id
  name    = each.value
  type    = "CNAME"
  ttl     = var.route53_default_ttl

  records = [
    var.domain,
  ]
}
