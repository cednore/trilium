data "aws_route53_zone" "apex" {
  name         = local.apex_domain
  private_zone = false
}

data "aws_acm_certificate" "apex" { # assuming this certificate is subject to all subdomains as well
  domain   = local.apex_domain
  statuses = ["ISSUED"]
}
