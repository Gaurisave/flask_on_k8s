terraform {
    required_providers {
        aws = "~> 4.12"
        helm = "~> 2.5"
        kubernetes = "~> 2.11"
    }
    backend "s3" {
        bucket = "TFstate-bucket"
        key = "terraform/state/testapp"
        region = us-east-1

        #For State Locking
        dynamodb_table = "testapp-terraform-state"
    }
}

provider "aws" {
    region = var.region
}

data "aws_vpc" "testapp" {
    filter {
        name = "tag:Name"
        values = ["testapp"]
  }
}

data "aws_subnet_ids" "testapp_sn" {
    vpc_id = data.aws_vpc.testapp.id
}

data "aws_availability_zones" "available" {}

data "aws_iam_role" "eks_master_role" {
    name = "eks_master_access_role_name"
}

data "aws_iam_role" "eks_nodegroup_role" {
    name = "eks_nodegroup_access_role_name"
}

data "aws_iam_role" "lbc_role" {
    name = "load balancer controller iam role"
}

resource "aws_security_group" "node_group_dev_sg" {
    name = "node_group_dev_sg"
    vpc_id = data.aws_vpc.testapp.id
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = [
            "10.0.0.0/8",
        ]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [
            "10.0.0.0/8",
        ]
    }
}

resource "aws_security_group" "node_group_prod_sg" {
    name_prefix = "node_group_prod_sg"
    vpc_id = data.aws_vpc.testapp.id
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = [
            "192.168.0.0/16",
        ]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [
            "192.168.0.0/16",
        ]
    }
}
