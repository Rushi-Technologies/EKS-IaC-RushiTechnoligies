output "eks_cluster_name" {
  value = aws_eks_cluster.main.arn
  description = "Value of the EKS cluster ARN"
}

output "eks_cluster_endpoint" {
  value = aws_eks_cluster.main.endpoint
  description = "Value of the EKS cluster ARN"
}