
resource "aws_instance" "ec2-hamid" {
  ami                    = var.AMIS[var.os]
  instance_type          = var.instance_type
  count                  = var.instance_count
  subnet_id              = aws_subnet.hamid-pub-1.id
  key_name               = var.instance_keypair
  vpc_security_group_ids = [aws_security_group.vpc_ssh.id,aws_security_group.vpc_web.id ]
  #user_data = file("${path.module}/web.sh") 
  tags = {
    Name = "hamid-ec2-${count.index + 1}" 
  }
}


