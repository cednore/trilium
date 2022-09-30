data "aws_route53_zone" "apex" {
  name         = local.apex_domain
  private_zone = false
}
