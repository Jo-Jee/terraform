variable "AWS_SSH_KEY_NAME" {
  description = "Name of the SSH keypair to use in AWS."
}

variable "aws_az" {
  description = "AZ to Use"
  type = list(string)
}

variable "k8s_vpc_cidr_block" {
  description = "CIDR for k8s cluster VPC"
}

variable "k8s_public_subnets_cidr" {
  description = "CIDR for k8s public subnets"
  type = list(string)
}

variable "k8s_master_node_type" {
  description = "Instance type of master nodes"
}

variable "k8s_master_num" {
  description = "Number of Kubernetes master Nodes"
}
