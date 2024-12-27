data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "network" {
  cidr_block           = var.vpc_cidr_block
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "${var.name}_network"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.network.id

  tags = {
    Name = "${var.name}_igw"
  }
}

resource "aws_subnet" "public" {
  for_each          = var.public_subnets
  vpc_id            = aws_vpc.network.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name}_public_subnet_${each.key}"
  }
}

resource "aws_subnet" "private" {
  for_each          = var.private_subnets
  vpc_id            = aws_vpc.network.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  tags = {
    Name = "${var.name}_private_subnet_${each.key}"
  }
}

resource "aws_subnet" "database" {
  for_each          = var.database_subnets
  vpc_id            = aws_vpc.network.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  tags = {
    Name = "${var.name}_database_subnet_${each.key}"
  }
}


resource "aws_route_table" "pub_rt" {
  vpc_id = aws_vpc.network.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "${var.name}_public_rt"
  }
}

resource "aws_route_table" "pri_rt" {
  vpc_id = aws_vpc.network.id

  tags = {
    Name = "${var.name}_private_rt"
  }
}

resource "aws_route_table" "database_rt" {
  vpc_id = aws_vpc.network.id

  tags = {
    Name = "${var.name}_database_rt"
  }
}

resource "aws_route_table_association" "public" {
  for_each       = aws_subnet.public
  subnet_id      = each.value.id
  route_table_id = aws_route_table.pub_rt.id
}

resource "aws_route_table_association" "private" {
  for_each       = aws_subnet.private
  subnet_id      = each.value.id
  route_table_id = aws_route_table.pri_rt.id
}

resource "aws_route_table_association" "database" {
  for_each       = aws_subnet.database
  subnet_id      = each.value.id
  route_table_id = aws_route_table.database_rt.id
}