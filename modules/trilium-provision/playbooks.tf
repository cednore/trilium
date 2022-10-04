resource "time_sleep" "initial_delay" {
  create_duration = "10s"
}

resource "null_resource" "trilium_installer" {
  depends_on = [
    time_sleep.initial_delay,
  ]

  triggers = {
    src_hash    = filesha256("${path.module}/trilium.yml")
    config_hash = filesha256("${path.module}/config/nginx/nginx.conf.j2")
    dependencies = jsonencode([
      var.cert,
      var.app_instance_username,
      var.app_instance_public_ip,
      var.app_instance_keypair_path,
      var.app_dir,
      var.domain,
      var.app_image,
      var.proxy_image,
      var.log_group_region,
      var.app_log_group,
      var.proxy_log_group,
    ])
  }

  provisioner "local-exec" {
    command = local.cmd_prepare_local_ssl_cert_files
  }

  provisioner "local-exec" {
    command = local.cmd_trilium_installer
  }

  lifecycle {
    create_before_destroy = true
  }
}
