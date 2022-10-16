resource "helm_release" "aws_lbc" {
    name = "aws-load-balancer-controller"
    repository = "https://aws.github.io/eks-charts"
    chart = "aws-load-balancer-controller"
    namespace = "kube-system"
    set {
        name = "image.repository"
        value = "602401143452.dkr.ecr.us-east-1.amazonaws.com/amazon/aws-load-balancer-controller"
    }
    set {
        name = "serviceAccount.create"
        value = true
    }
    set {
        name = "serviceAccount.name"
        value = "aws-load-balancer-controller"
    }
    set {
        name = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
        value = data.aws_iam_role.lbc_role.arn
    }
    set {
        name = "vpcID"
        value = data.aws_vpc.testapp.id
    }
    set {
        name = "region"
        value = var.region
    }
    set {
        name = "clusterName"
        value = aws_eks_cluster.testapp_cluster.id
    }
}
