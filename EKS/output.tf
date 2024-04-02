# output "ec2_instance_public_ips" {
#   value       = module.ec2_hamid.ec2_publicIp
# }

output "eks_cluster_oidc" {
    value = aws_iam_openid_connect_provider.eks.id
}