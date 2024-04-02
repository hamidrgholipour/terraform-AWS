

resource "null_resource" "connection"  {
    # depends_on = [ aws_efs_file_system.hamid_efs]
    count = "${var.instance_count}"

	connection {
    #for_each = toset(aws_instance.ec2-hamid.id)
		type     = "ssh"
		user     = "ec2-user"
		private_key = tls_private_key.new-key.private_key_pem
		host     = aws_instance.ec2-hamid[count.index].public_ip
	}	
	
// Mounting the EFS on the folder /var/www/html and pulling the code from github


 provisioner "remote-exec" {
      inline = [
        "sudo yum install httpd  php git -y",
        "sudo systemctl restart httpd",
        "sudo systemctl enable httpd",
        "sudo yum install -y amazon-efs-utils",
        # **  note work mount -a because initiatin dns takes time
        "sudo mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${aws_efs_file_system.hamid_efs.dns_name}:/  /var/www/html",
        "sudo sh -c 'echo ${aws_efs_file_system.hamid_efs.dns_name}:/ /var/www/html nfs4 defaults,_netdev 0 0 >>  /etc/fstab'",
        "sudo git clone https://github.com/Priyanshi541/HTask2.git /var/www/html/"
        #  "bash efs_mount.sh",
    ]
  }

    # provisioner "file" {
  #   source      = "efs_mount.sh"
  #   destination = "efs_mount.sh"
  # }
}


# resource "terraform_data" "public_ip_print" {
#   provisioner "local-exec" {
#   #for_each = toset(aws_instance.ec2-hamid[*].public_ip)
#   for_each = var.instance_count
#   command = "echo ${each.value} > output.txt"
#   }
# }

# resource "terraform_data" "public_ip_print_2" {
#   provisioner "local-exec" {
#   # command = "echo ${aws_instance.ec2-hamid[*].public_ip} > output.txt"
#   command = "echo testttttt"
#   }
# }