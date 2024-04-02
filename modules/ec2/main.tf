
resource "aws_instance" "ec2" {
  ami                    = var.AMIS[var.os]
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  key_name               = var.keypair
  vpc_security_group_ids = var.vpc_security_group_id
  
  tags = {
    Name = var.name
  }

}


