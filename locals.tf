locals {
  stage                = terraform.workspace
  private_key_filename = "kp-${var.app}-root-${terraform.workspace}.pem"
}
