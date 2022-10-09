variables "aws_access_key" = {}
variable "aws_secret_key" = {}

variable "region" {
    description = "Environment region"
    default = "us-east-1"
}

locals {
  subnet_ids_list = tolist(data.aws_subnet_ids.testapp_sn.ids)
  subnet_ids_random_index = random_id.index.dec % length(data.aws_subnet_ids.testapp_sn.ids)
  node_subnet_id = local.subnet_ids_list[local.subnet_ids_random_index]
}

variable cluster_ca_cert = #TODO update cert value