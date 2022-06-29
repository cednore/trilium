resource "aws_vpc" "root" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(local.default_tags, {
    Name = "vpc-${local.slug}"
  })
}

resource "aws_subnet" "public" {
  count = var.vpc_subnets

  vpc_id                  = aws_vpc.root.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, count.index)
  availability_zone       = element(local.availability_zones, count.index % length(local.availability_zones))
  map_public_ip_on_launch = true

  tags = merge(local.default_tags, {
    Name = "sn-${local.slug}-public-${count.index}"
  })
}

resource "aws_internet_gateway" "root" {
  vpc_id = aws_vpc.root.id

  tags = merge(local.default_tags, {
    Name = "igw-${local.slug}"
  })
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.root.id

  tags = merge(local.default_tags, {
    Name = "rt-${local.slug}-public"
  })
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.root.id
}

resource "aws_route_table_association" "public" {
  count = var.vpc_subnets

  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id

  depends_on = [
    aws_subnet.public,
  ]
}
