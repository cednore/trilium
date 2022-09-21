resource "aws_route53_record" "subdomain" {
  zone_id = data.aws_route53_zone.apex.zone_id
  name    = var.domain
  type    = "CNAME"
  ttl     = var.route53_default_ttl

  records = [
    aws_lb.app.dns_name,
  ]
}
