resource "aws_route53_record" "subdomain" {
  zone_id = var.route53_apex_zone_id
  name    = var.domain
  type    = "CNAME"
  ttl     = var.route53_default_ttl

  records = [
    aws_lb.app.dns_name,
  ]
}

resource "aws_route53_record" "subdomain_cname_cert_validation" {
  zone_id         = var.route53_apex_zone_id
  name            = tolist(aws_acm_certificate.subdomain.domain_validation_options)[0].resource_record_name
  type            = tolist(aws_acm_certificate.subdomain.domain_validation_options)[0].resource_record_type
  ttl             = 300
  allow_overwrite = true

  records = [
    tolist(aws_acm_certificate.subdomain.domain_validation_options)[0].resource_record_value,
  ]
}
