resource "aws_vpc" "hamid" {
  cidr_block           = var.vpc_cidr_block
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "hamid_vpc"
  }
}

resource "aws_subnet" "hamid_pub_1" {
  vpc_id                  = aws_vpc.hamid.id
  cidr_block              = cidrsubnet(aws_vpc.hamid.cidr_block, 8, 1)
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE1
  tags = {
    Name = "hamid_pub_1"
  }
}

resource "aws_subnet" "hamid_pub_2" {
  vpc_id                  = aws_vpc.hamid.id
  cidr_block              = cidrsubnet(aws_vpc.hamid.cidr_block, 8, 2)
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE2
  tags = {
    Name = "hamid_pub_2"
  }
}


resource "aws_subnet" "hamid_pub_3" {
  vpc_id                  = aws_vpc.hamid.id
  cidr_block              = cidrsubnet(aws_vpc.hamid.cidr_block, 8, 3)
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE3
  tags = {
    Name = "hamid_pub_3"
  }
}


resource "aws_subnet" "hamid_priv_1" {
  vpc_id                  = aws_vpc.hamid.id
  cidr_block              = cidrsubnet(aws_vpc.hamid.cidr_block, 8, 10)
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE1
  tags = {
    Name = "hamid_priv_1"
  }
}


resource "aws_subnet" "hamid_priv_2" {
  vpc_id                  = aws_vpc.hamid.id
  cidr_block              = cidrsubnet(aws_vpc.hamid.cidr_block, 8, 11)
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE2
  tags = {
    Name = "hamid_priv_2"
  }
}


resource "aws_subnet" "hamid_priv_3" {
  vpc_id                  = aws_vpc.hamid.id
  cidr_block              = cidrsubnet(aws_vpc.hamid.cidr_block, 8, 12)
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE3
  tags = {
    Name = "hamid_priv_3"
  }
}

resource "aws_internet_gateway" "hamid_IGW" {
  vpc_id = aws_vpc.hamid.id
  tags = {
    Name = "hamid_IGW"
  }
}

resource "aws_route_table" "hamid_pub_RT" {
  vpc_id = aws_vpc.hamid.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.hamid_IGW.id
  }

  tags = {
    Name = "hamid_pub_RT"
  }
}


resource "aws_route_table_association" "hamid_pub_1-a" {
  subnet_id      = aws_subnet.hamid_pub_1.id
  route_table_id = aws_route_table.hamid_pub_RT.id
}

resource "aws_route_table_association" "hamid_pub_2-a" {
  subnet_id      = aws_subnet.hamid_pub_2.id
  route_table_id = aws_route_table.hamid_pub_RT.id
}
resource "aws_route_table_association" "hamid_pub_3-a" {
  subnet_id      = aws_subnet.hamid_pub_3.id
  route_table_id = aws_route_table.hamid_pub_RT.id
}
