data "aws_route53_zone" "apex" {
  name         = local.apex_domain
  private_zone = false
}

data "aws_acm_certificate" "apex" {
  domain   = local.apex_domain
  statuses = ["ISSUED"]
}
