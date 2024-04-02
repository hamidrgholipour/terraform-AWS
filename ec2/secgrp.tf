resource "aws_security_group" "vpc_ssh" {
  vpc_id      = aws_vpc.hamid.id
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
  vpc_id      = aws_vpc.hamid.id
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

resource "aws_security_group" "vpc_efs" {
  vpc_id      = aws_vpc.hamid.id
  name        = "efs-sg"
  description = "Sec Grp for  efs"
  egress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-efs"
  }
}

