resource "aws_route53_record" "subdomain" {
  zone_id = data.aws_route53_zone.apex.zone_id
  name    = var.domain
  type    = "A"
  ttl     = var.route53_default_ttl

  records = [
    var.app_instance_public_ip,
  ]
}
