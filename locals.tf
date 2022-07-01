locals {
  stage                = terraform.workspace
  private_key_filename = "kp-${var.app}-app-${terraform.workspace}.pem"
}
