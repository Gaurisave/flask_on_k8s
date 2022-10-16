resource "aws_eks_cluster" "testapp_cluster" {
    name = "testapp_cluster"
    role_arn = aws_iam_role.eks_master_role.arn
    vpc_config {
        subnet_ids = local.node_subnet_id
    }
}

resource "aws_eks_node_group" "node-group-dev" {
    cluster_name = aws_eks_cluster.testapp_cluster.name
    node_group_name = "node-group-dev"
    node_role_arn = aws_iam_role.eks_nodegroup_role.arn
    subnet_ids = local.node_subnet_id
    source_security_group_ids = aws_security_group.node_group_dev_sg.id
    instance_types = ["t3.large"]
    scaling_config {
        desired_size = 3
        min_size = 3
        max_size = 5
    }
}

resource "aws_eks_node_group" "node-group-prod" {
    cluster_name = aws_eks_cluster.testapp_cluster.name
    node_group_name = "node-group-prod"
    node_role_arn = aws_iam_role.eks_nodegroup_role.arn
    subnet_ids = local.node_subnet_id
    source_security_group_ids = aws_security_group.node_group_prod_sg.id
    instance_types = ["m5.2xlarg"]
    scaling_config {
        desired_size = 3
        min_size = 3
        max_size = 10
    }
}