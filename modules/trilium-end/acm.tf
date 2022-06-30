resource "aws_acm_certificate" "subdomain" {
  domain_name       = var.domain
  validation_method = "DNS"

  tags = merge(local.default_tags, {
    Name = "cert-${local.slug}"
  })

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "subdomain" {
  certificate_arn = aws_acm_certificate.subdomain.arn
  validation_record_fqdns = [
    aws_route53_record.subdomain_cname_cert_validation.fqdn,
  ]

  timeouts {
    create = "10m"
  }
}
