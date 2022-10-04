locals {
  default_tags = {
    App    = var.app
    Module = var.module
    Stage  = var.stage
  }
  slug = "${var.app}-${var.module}-${var.stage}"

  cmd_prepare_local_ssl_cert_files = <<BASH
    mkdir -p ${path.module}/config/ssl/cert && \
    echo "${var.cert.certificate_pem}" > ${path.module}/config/ssl/cert/${var.domain}.crt && \
    echo "${var.cert.private_key_pem}" > ${path.module}/config/ssl/cert/${var.domain}.key
  BASH
  cmd_trilium_installer            = <<BASH
    ANSIBLE_NOCOWS=1 ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook ${path.module}/trilium.yml \
      -u ${var.app_instance_username} \
      -i '${var.app_instance_public_ip},' \
      --private-key ${var.app_instance_keypair_path} \
      -e 'app_dir=${var.app_dir}' \
      -e 'app_domain=${var.domain}' \
      -e 'app_image=${var.app_image}' \
      -e 'proxy_image=${var.proxy_image}' \
      -e 'awslogs_region=${var.log_group_region}' \
      -e 'awslogs_group_app=${var.app_log_group}' \
      -e 'awslogs_group_proxy=${var.proxy_log_group}'
  BASH
}
