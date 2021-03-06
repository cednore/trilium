locals {
  apex_domain = join(".", slice(
    split(".", var.domain),
    length(split(".", var.domain)) - 2,
    length(split(".", var.domain))
    )
  ) # Extract apex domain from app domain

  app_container_name_prefix = "app"
  data_volume_mount_path    = "/mnt/app_data"
  keypair_filename          = ".keypair.pem"
}
