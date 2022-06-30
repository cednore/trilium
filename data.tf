data "aws_route53_zone" "apex" {
  name         = var.apex_domain
  private_zone = false
}

data "aws_acm_certificate" "apex" {
  domain   = var.apex_domain
  statuses = ["ISSUED"]
}
