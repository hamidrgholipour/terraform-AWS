resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.vpc_public_subnets[0]
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE1
  tags = {
    Name = "hamid_public_1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.vpc_public_subnets[1]
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE2
  tags = {
    Name = "hamid_public_2"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.vpc_private_subnets[0]
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE1
  tags = {
    Name = "hamid_private_1"
  }
}


resource "aws_internet_gateway" "aws_internet_gateway" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "hamid-IGW"
  }
}

resource "aws_route_table" "vpc_pub_RT" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.aws_internet_gateway.id
  }

  tags = {
    Name = "hamid-pub-RT"
  }
}


resource "aws_route_table_association" "route_table_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.vpc_pub_RT.id
}

resource "aws_route_table_association" "route_table_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.vpc_pub_RT.id
}