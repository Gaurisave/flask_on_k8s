terraform {
    backend "s3" {
        bucket = "TFstate-bucket"
        key = "terraform/state/testapp"
        region = var.region
    }
}

provider "kubernetes" {
    host = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(var.cluster_ca_cert)
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
}
