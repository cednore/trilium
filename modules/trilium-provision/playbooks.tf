resource "null_resource" "app_data_volume_provisioner" {
  triggers = {
    src_hash = filesha256("${path.module}/playbooks/app-data.yml")
    variables = jsonencode([
      var.app_instance_public_ip,
      var.app_privkey_path,
      var.data_volume_device_name,
      var.data_volume_mount_path,
      var.data_volume_filesystem,
    ])
  }

  provisioner "local-exec" {
    command = <<BASH
                sleep 10s && ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook ${path.module}/playbooks/app-data.yml \
                  -u ubuntu \
                  -i '${var.app_instance_public_ip},' \
                  --private-key ${var.app_privkey_path} \
                  -e 'device_name=${var.data_volume_device_name}' \
                  -e 'mount_path=${var.data_volume_mount_path}' \
                  -e 'filesystem=${var.data_volume_filesystem}'
              BASH
  }
}

resource "null_resource" "app_instance_provisioner" {
  depends_on = [
    null_resource.app_data_volume_provisioner,
  ]

  triggers = {
    src_hash = filesha256("${path.module}/playbooks/app.yml")
    variables = jsonencode([
      var.app_instance_public_ip,
      var.app_privkey_path,
      var.app_image,
      var.app_image_tag,
      var.app_container_count,
      var.app_container_name_prefix,
      var.app_container_ports,
      var.data_volume_mount_path,
      var.app_container_data_path,
      data.aws_region.current.name,
      var.app_container_log_group,
    ])
  }

  provisioner "local-exec" {
    command = <<BASH
                sleep 10s && ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook ${path.module}/playbooks/app.yml \
                  -u ubuntu \
                  -i '${var.app_instance_public_ip},' \
                  --private-key ${var.app_privkey_path} \
                  -e 'image=${var.app_image}' \
                  -e 'tag=${var.app_image_tag}' \
                  -e 'container_count=${var.app_container_count}' \
                  -e 'container_name_prefix=${var.app_container_name_prefix}' \
                  -e 'ports=${var.app_container_ports}' \
                  -e 'volumes=${var.data_volume_mount_path}:${var.app_container_data_path}' \
                  -e 'awslogs_region=${data.aws_region.current.name}' \
                  -e 'awslogs_group=${var.app_container_log_group}'
              BASH
  }
}
