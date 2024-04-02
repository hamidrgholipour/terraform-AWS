output "ec2_publicIp" {
  value = aws_instance.ec2[*].public_ip
}