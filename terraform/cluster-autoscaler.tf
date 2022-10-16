resource "helm-release" "eks_cluster_autoscaler" {
    name = "eks_cluster_autoscaler"
    repository = "https://github.com/kubernetes/autoscaler"
    chart = "cluster-autoscaler"
    namespace = "kube-system"
    set = {
        name = "cloudProvider"
        value = "aws"
    }
    set {
        name = "autoDiscovery.clusterName"
        value = aws_eks_cluster.testapp_cluster.id
    }
    set {
        name = "region"
        value = var.region
    }
    set {
        name = "rbac.serviceAccount.name"
        value = "cluster-autoscaler"
    }
    set {
        name = "rbac.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
        value = data.aws_iam_role.lbc_role.arn
    }
}