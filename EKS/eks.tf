resource "aws_iam_role" "eks_cluster_role" {
  name = "eks_cluster"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "hamid_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_role.name
}

resource "aws_iam_role_policy_attachment" "hamid_AmazonEC2ContainerRegistryReadOnly" {
 policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
 role    = aws_iam_role.eks_cluster_role.name
}

resource "aws_eks_cluster" "eks_cluster" {
  name     = "eks_cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn
  version = "1.29"
  
  vpc_config {
    subnet_ids = [
      data.aws_subnet.public_subnet_1.id,
      data.aws_subnet.public_subnet_2.id
    ]
    endpoint_public_access = true
    public_access_cidrs = ["0.0.0.0/0"]
    
  }

  depends_on = [
    aws_iam_role_policy_attachment.hamid_AmazonEKSClusterPolicy, 
    aws_iam_role_policy_attachment.hamid_AmazonEC2ContainerRegistryReadOnly
  ]

  kubernetes_network_config {
    service_ipv4_cidr = "192.168.0.0/16"
    ip_family = "ipv4"
  }
}





output "endpoint" {
  value = aws_eks_cluster.eks_cluster.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.eks_cluster.certificate_authority[0].data
}