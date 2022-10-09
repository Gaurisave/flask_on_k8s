module "eks" {
    source  = "terraform-aws-modules/eks/aws"
    version = "18.26.6"
    cluster_name    = testapp_cluster
    cluster_version = "1.22"
    vpc_id     = data.aws_vpc.testapp.id
    subnet_ids = local.node_subnet_id

    eks_managed_node_group_defaults = {
        instance_type = ["m5.large", "m5n.2xlarge"]
        attach_cluster_primary_security_group = true
    }

    eks_managed_node_groups = {
        dev = {
            name = "node-group-dev"
            instance_types = ["m5.large"]
            min_size     = 3
            max_size     = 5
            desired_size = 3
            vpc_security_group_ids = [
                aws_security_group.node_group_dev_sg.id
            ]
        }
        prod = {
            name = "node-group-prod"
            instance_types = ["m5.2xlarge"]
            min_size     = 3
            max_size     = 10
            desired_size = 3
            vpc_security_group_ids = [
                aws_security_group.node_group_prod_sg.id
            ]
        }
    }
}
