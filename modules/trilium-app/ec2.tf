resource "aws_instance" "app" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  key_name               = aws_key_pair.main.key_name
  vpc_security_group_ids = var.sg_ids
  iam_instance_profile   = aws_iam_instance_profile.app.id

  tags = merge(local.default_tags, {
    Name = "i-${local.slug}-app"
  })

  lifecycle {
    ignore_changes = [
      ami, # Ignore ami updates
    ]
  }
}

resource "aws_key_pair" "main" {
  key_name   = "kp-${local.slug}"
  public_key = var.pubkey

  tags = merge(local.default_tags, {
    Name = "kp-${local.slug}"
  })
}
