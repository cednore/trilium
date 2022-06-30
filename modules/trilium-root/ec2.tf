resource "aws_instance" "app" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public[0].id
  key_name      = aws_key_pair.main.key_name
  vpc_security_group_ids = [
    aws_security_group.ssh.id,
    aws_security_group.http.id,
    aws_security_group.https.id,
    aws_security_group.out.id,
  ]

  tags = merge(local.default_tags, {
    Name = "i-${local.slug}-app"
  })
}

resource "aws_key_pair" "main" {
  key_name   = "kp-${local.slug}"
  public_key = var.ec2_pubkey

  tags = merge(local.default_tags, {
    Name = "kp-${local.slug}"
  })
}
