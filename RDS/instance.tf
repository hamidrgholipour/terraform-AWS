resource "aws_instance" "hamid-app" {
  ami                    = var.AMIS["ubuntu"]
  instance_type          = "t2.micro"
  count                  = 1
  subnet_id              = aws_subnet.hamid-pub-1.id
  key_name               = aws_key_pair.instance_keypair.key_name
  vpc_security_group_ids = [aws_security_group.vpc_ssh.id,aws_security_group.vpc_web.id ]
  tags = {
    Name = "hamid-app-${count.index + 1}" 
  }


    provisioner "file" {
    content     = templatefile("template/db-deploy.tmpl", { rds-endpoint = aws_db_instance.rds-resource.address, dbuser = var.db_user, dbpass = var.db_pass })
    destination = "/tmp/db-deploy.sh"
      connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("./instance_keypair.pem")
      host        = self.public_ip
    }    
  }
 

    provisioner "file" {
    source     = "./db-file/db_backup.sql"
    destination = "/tmp/db_backup.sql"
      connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("./instance_keypair.pem")
      host        = self.public_ip
    }

  }  


  provisioner "remote-exec" {
    inline = [
      "echo test > /tmp/test",
      "chmod +x /tmp/db-deploy.sh",
      "sudo /tmp/db-deploy.sh"
    ]
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("./instance_keypair.pem")
      host        = self.public_ip
    }  
  }

  
#  depends_on = [aws_db_instance.rds-resource]

}



output "PublicIP" {
  value = aws_instance.hamid-app[*].public_ip
}
