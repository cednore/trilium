resource "aws_security_group" "ssh" {
  name        = "secg-${local.slug}-ssh"
  description = "Allow SSH connection"
  vpc_id      = aws_vpc.root.id

  ingress {
    description = "Allow inbound traffic from anywhere to SSH port"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow outbound traffic from SSH port to anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.default_tags, {
    Name = "secg-${local.slug}-ssh"
  })
}

resource "aws_security_group" "lb" {
  name        = "secg-${local.slug}-lb"
  description = "Security group for LB instances"
  vpc_id      = aws_vpc.root.id

  ingress {
    description = "Allow inbound traffic from anywhere to HTTP port"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow inbound traffic from anywhere to HTTPS port"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow outbound traffic to anywhere"
    from_port   = 0
    to_port     = 0
    protocol    = "all"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.default_tags, {
    Name = "secg-${local.slug}-lb"
  })
}

resource "aws_security_group" "app" {
  name        = "secg-${local.slug}-app"
  description = "Security group for app instance"
  vpc_id      = aws_vpc.root.id

  ingress {
    description     = "Allow inbound traffic from LB to HTTP port"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.lb.id]
  }

  egress {
    description = "Allow outbound traffic to anywhere"
    from_port   = 0
    to_port     = 0
    protocol    = "all"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.default_tags, {
    Name = "secg-${local.slug}-app"
  })
}
