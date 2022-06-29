resource "aws_security_group" "http" {
  name        = "secg-${local.slug}-http"
  description = "Allow ingress HTTP traffic"
  vpc_id      = aws_vpc.root.id

  ingress {
    description = "Allow inbound traffic from anywhere to HTTP port"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.default_tags, {
    Name = "secg-${local.slug}-http"
  })
}

resource "aws_security_group" "https" {
  name        = "secg-${local.slug}-https"
  description = "Allow ingress HTTPS traffic"
  vpc_id      = aws_vpc.root.id

  ingress {
    description = "Allow inbound traffic from anywhere to HTTPS port"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.default_tags, {
    Name = "secg-${local.slug}-https"
  })
}

resource "aws_security_group" "out" {
  name        = "secg-${local.slug}-out"
  description = "Allow all egress traffic"
  vpc_id      = aws_vpc.root.id

  egress {
    description = "Allow outbound traffic to anywhere"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.default_tags, {
    Name = "secg-${local.slug}-out"
  })
}
