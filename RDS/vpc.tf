resource "aws_vpc" "hamid-vpc" {
  cidr_block           = var.vpc_cidr_block
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "hamid-vpc"
  }
}

resource "aws_subnet" "hamid-pub-1" {
  vpc_id                  = aws_vpc.hamid-vpc.id
  cidr_block              = cidrsubnet(aws_vpc.hamid-vpc.cidr_block, 8, 1)
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE1
  tags = {
    Name = "hamid-pub-1"
  }
}

resource "aws_subnet" "hamid-pub-2" {
  vpc_id                  = aws_vpc.hamid-vpc.id
  cidr_block              = cidrsubnet(aws_vpc.hamid-vpc.cidr_block, 8, 2)
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE1
  tags = {
    Name = "hamid-pub-2"
  }
}

resource "aws_subnet" "hamid-pub-3" {
  vpc_id                  = aws_vpc.hamid-vpc.id
  cidr_block              = cidrsubnet(aws_vpc.hamid-vpc.cidr_block, 8, 3)
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE1
  tags = {
    Name = "hamid-pub-3"
  }
}


resource "aws_subnet" "hamid-priv-1" {
  vpc_id                  = aws_vpc.hamid-vpc.id
  cidr_block              = cidrsubnet(aws_vpc.hamid-vpc.cidr_block, 8, 11)
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE1
  tags = {
    Name = "hamid-priv-1"
  }
}

resource "aws_subnet" "hamid-priv-2" {
  vpc_id                  = aws_vpc.hamid-vpc.id
  cidr_block              = cidrsubnet(aws_vpc.hamid-vpc.cidr_block, 8, 12)
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE1
  tags = {
    Name = "hamid-priv-2"
  }
}

resource "aws_subnet" "hamid-priv-3" {
  vpc_id                  = aws_vpc.hamid-vpc.id
  cidr_block              = cidrsubnet(aws_vpc.hamid-vpc.cidr_block, 8, 13)
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE1
  tags = {
    Name = "hamid-priv-3"
  }
}

resource "aws_internet_gateway" "hamid-IGW" {
  vpc_id = aws_vpc.hamid-vpc.id
  tags = {
    Name = "hamid-IGW"
  }
}

resource "aws_route_table" "hamid-pub-RT" {
  vpc_id = aws_vpc.hamid-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.hamid-IGW.id
  }

  tags = {
    Name = "hamid-pub-RT"
  }
}


resource "aws_route_table_association" "hamid-pub-1-a" {
  subnet_id      = aws_subnet.hamid-pub-1.id
  route_table_id = aws_route_table.hamid-pub-RT.id
}

resource "aws_route_table_association" "hamid-pub-2-a" {
  subnet_id      = aws_subnet.hamid-pub-2.id
  route_table_id = aws_route_table.hamid-pub-RT.id
}
resource "aws_route_table_association" "hamid-pub-3-a" {
  subnet_id      = aws_subnet.hamid-pub-3.id
  route_table_id = aws_route_table.hamid-pub-RT.id
}
