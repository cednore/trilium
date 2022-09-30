output "cert" {
  description = "The SSL certificate"
  value = {
    certificate_pem = lookup(acme_certificate.certificate, "certificate_pem")
    issuer_pem      = lookup(acme_certificate.certificate, "issuer_pem")
    private_key_pem = lookup(acme_certificate.certificate, "private_key_pem")
  }
  sensitive = true
}
