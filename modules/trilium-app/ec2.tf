resource "aws_instance" "app" {
  ami                  = data.aws_ami.ubuntu.id
  instance_type        = var.instance_type
  key_name             = aws_key_pair.main.key_name
  iam_instance_profile = aws_iam_instance_profile.app.id

  network_interface {
    network_interface_id = aws_network_interface.app.id
    device_index         = 0
  }

  tags = merge(local.default_tags, {
    Name = "i-${local.slug}-app"
  })

  lifecycle {
    ignore_changes = [
      ami, # Ignore ami updates
    ]
  }
}

resource "aws_network_interface" "app" {
  subnet_id       = var.subnet_id
  security_groups = var.sg_ids

  tags = merge(local.default_tags, {
    Name = "ni-${local.slug}-app"
  })
}

resource "aws_key_pair" "main" {
  key_name   = "kp-${local.slug}"
  public_key = var.pubkey

  tags = merge(local.default_tags, {
    Name = "kp-${local.slug}"
  })
}
