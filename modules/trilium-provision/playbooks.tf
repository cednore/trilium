resource "time_sleep" "initial_delay" {
  create_duration = "10s"
}

resource "null_resource" "trilium_data_volume_provisioner" {
  depends_on = [
    time_sleep.initial_delay,
  ]

  triggers = {
    src_hash = filesha256("${path.module}/playbooks/trilium-data.yml")
    dependencies = sha256(jsonencode([
      var.app_instance_public_ip,
      var.app_keypair_path,
      var.data_volume_id,
      var.data_volume_mount_path,
      var.data_volume_filesystem,
    ]))
  }

  provisioner "local-exec" {
    command = local.cmd_trilium_data_volume_provisioner
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "null_resource" "trilium_installer" {
  depends_on = [
    null_resource.trilium_data_volume_provisioner,
  ]

  triggers = {
    src_hash = filesha256("${path.module}/playbooks/trilium.yml")
    dependencies = sha256(jsonencode([
      var.app_instance_public_ip,
      var.app_keypair_path,
      var.app_image,
      var.app_image_tag,
      var.app_container_count,
      var.app_container_name_prefix,
      var.app_container_ports,
      var.data_volume_mount_path,
      var.app_container_data_path,
      data.aws_region.current.name,
      var.app_container_log_group,
    ]))
  }

  provisioner "local-exec" {
    command = local.cmd_trilium_installer
  }

  lifecycle {
    create_before_destroy = true
  }
}
