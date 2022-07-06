locals {
  stage = terraform.workspace

  app_container_name_prefix = "app"
  data_volume_mount_path    = "/mnt/app_data"
  keypair_filename          = "kp-${var.app}-app-${terraform.workspace}.pem"
}
