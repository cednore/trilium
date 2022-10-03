locals {
  default_tags = {
    App    = var.app
    Module = var.module
    Stage  = var.stage
  }
  slug = "${var.app}-${var.module}-${var.stage}"

  cmd_trilium_installer = <<BASH
    ANSIBLE_NOCOWS=1 ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook ${path.module}/playbooks/trilium.yml \
      -u ${var.app_instance_username} \
      -i '${var.app_instance_public_ip},' \
      --private-key ${var.app_instance_keypair_path} \
      -e 'image=${var.app_image}' \
      -e 'host_data_dir=${var.app_instance_data_dir}' \
      -e 'awslogs_region=${var.log_group_region}' \
      -e 'awslogs_group_app=${var.app_log_group}' \
      -e 'awslogs_group_proxy=${var.proxy_log_group}'
  BASH
}
