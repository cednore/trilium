locals {
  app_env_secrets           = jsondecode(data.aws_secretsmanager_secret_version.app_env.secret_string)
  app_container_name_prefix = "app"
  data_volume_mount_path    = "/mnt/app_data"
  keypair_filename          = ".keypair.pem"
}
