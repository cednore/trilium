data "aws_route53_zone" "apex" {
  name         = var.apex_domain
  private_zone = false
}

data "aws_acm_certificate" "apex" {
  domain   = var.apex_domain
  statuses = ["ISSUED"]
}

# data "aws_secretsmanager_secret_version" "pubkey" {
#   secret_id = "scrt-${var.app}-app-${local.stage}-pubkey"
# }
