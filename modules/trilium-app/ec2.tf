resource "aws_instance" "app" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  key_name               = aws_key_pair.main.key_name
  vpc_security_group_ids = var.instance_sg_ids

  provisioner "local-exec" {
    command = <<BASH
                sleep 10s && ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook ${path.module}/app-playbook.yml \
                  -u ubuntu \
                  -i '${self.public_ip},' \
                  --private-key ${var.instance_privkey_path} \
                  -e 'image=${var.app_image}' \
                  -e 'tag=${var.app_image_tag}' \
                  -e 'container_count=${var.app_container_count}' \
                  -e 'container_name=${var.app_container_name}' \
                  -e 'ports=${var.app_container_ports}' \
                  -e 'volumes=${var.app_container_volumes}'
              BASH
  }

  tags = merge(local.default_tags, {
    Name = "i-${local.slug}-app"
  })
}

resource "aws_key_pair" "main" {
  key_name   = "kp-${local.slug}"
  public_key = var.instance_pubkey

  tags = merge(local.default_tags, {
    Name = "kp-${local.slug}"
  })
}
