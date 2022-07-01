locals {
  stage = terraform.workspace

  data_volume_mount_path = "/mnt/app_data"
  private_key_filename   = "kp-${var.app}-app-${terraform.workspace}.pem"
}
