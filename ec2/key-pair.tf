resource "tls_private_key" "new-key" {
  algorithm = "RSA"
}
resource "aws_key_pair" "new-key" {
  key_name = "example-key"
  public_key = tls_private_key.new-key.public_key_openssh
  
  provisioner "local-exec" { 
      command = "echo '${tls_private_key.new-key.private_key_pem}' > new-key.pem && cp new-key.pem /root/new-key.pem"
    }
}
