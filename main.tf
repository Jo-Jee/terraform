terraform {
  required_version = ">= 1.2.6"
}

provider "aws" {
  profile = "cozyband"
  region = "ap-northeast-2"
}

data "aws_availability_zones" "available" {
  state = "available"
}

module "k8s" {
  source = "./k8s"

  AWS_SSH_KEY_NAME = var.AWS_SSH_KEY_NAME
  aws_az = data.aws_availability_zones.available.names
  k8s_vpc_cidr_block = var.k8s_vpc_cidr_block
  k8s_public_subnets_cidr = var.k8s_public_subnets_cidr
  k8s_master_node_type = var.k8s_master_node_type
  k8s_master_num = var.k8s_master_num
}