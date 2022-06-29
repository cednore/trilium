data "aws_route53_zone" "root" {
  name         = local.root_domain
  private_zone = false
}

data "aws_acm_certificate" "root" {
  domain   = local.root_domain
  statuses = ["ISSUED"]
}
