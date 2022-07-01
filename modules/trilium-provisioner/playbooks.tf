resource "null_resource" "app_data_volume" {
  triggers = {
    src_hash = filesha256("${path.module}/playbooks/app-data.yml")
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

resource "null_resource" "app_instance" {
  depends_on = [
    null_resource.app_data_volume,
  ]

  triggers = {
    src_hash = filesha256("${path.module}/playbooks/app.yml")
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
                  -e 'volumes=${var.app_container_volumes}' \
                  -e 'awslogs_region=${data.aws_region.current.name}' \
                  -e 'awslogs_group=${var.app_container_log_group}'
              BASH
  }
}
