output "cluster_endpoint" {
    description = "Endpoint for EKS control plane"
    value = aws_eks_cluster.testapp_cluster.endpoint
}

output "cluster_id" {
    description = "ID of the EKS cluster"
    value = aws_eks_cluster.testapp_cluster.id
}