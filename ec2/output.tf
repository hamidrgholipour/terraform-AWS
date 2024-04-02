output "PublicIP" {
  value = aws_instance.ec2-hamid[*].public_ip
}

output "private_key" {
  value     = tls_private_key.new-key.private_key_pem
  sensitive = true
}

output "efsName"{
  value = aws_efs_file_system.hamid_efs.dns_name
}