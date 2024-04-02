
resource "aws_security_group" "vpc_ssh" {
  vpc_id      = aws_vpc.hamid-vpc.id
  name        = "hamid-stack-sg"
  description = "Sec Grp for hamid ssh"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-ssh"
  }
}

resource "aws_security_group" "vpc_web" {
  vpc_id      = aws_vpc.hamid-vpc.id
  name        = "web-sg"
  description = "Sec Grp for  web"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-web"
  }
}

resource "aws_security_group" "vpc_rds" {
  vpc_id      = aws_vpc.hamid-vpc.id
  name        = "rds-sg"
  description = "Sec Grp for  rds"
  egress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-rds"
  }
}