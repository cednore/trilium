resource "aws_acm_certificate" "certificate" {
  count = var.create_acm_certificate ? 1 : 0

  certificate_body  = acme_certificate.certificate.certificate_pem
  private_key       = acme_certificate.certificate.private_key_pem
  certificate_chain = acme_certificate.certificate.issuer_pem

  tags = {
    Name = var.domain
  }
}
