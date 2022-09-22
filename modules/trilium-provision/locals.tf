locals {
  default_tags = {
    App    = var.app
    Module = var.module
    Stage  = var.stage
  }
  slug = "${var.app}-${var.module}-${var.stage}"

  cmd_trilium_data_volume_provisioner = <<BASH
    ANSIBLE_NOCOWS=1 ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook ${path.module}/playbooks/trilium-data.yml \
      -u ubuntu \
      -i '${var.app_instance_public_ip},' \
      --private-key ${var.app_keypair_path} \
      -e 'volume_serial=${replace(var.data_volume_id, "-", "")}' \
      -e 'mount_path=${var.data_volume_mount_path}' \
      -e 'filesystem=${var.data_volume_filesystem}'
  BASH

  cmd_trilium_installer = <<BASH
    ANSIBLE_NOCOWS=1 ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook ${path.module}/playbooks/trilium.yml \
      -u ubuntu \
      -i '${var.app_instance_public_ip},' \
      --private-key ${var.app_keypair_path} \
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
