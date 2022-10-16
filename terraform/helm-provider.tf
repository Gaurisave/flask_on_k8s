provider "helm" {
    kubernetes {
        host = aws_eks_cluster.testapp_cluster.endpoint
        cluster_ca_certificate = base64decde(aws_eks_cluster.testapp_cluster.certificae_authority[0].data)
    }
}