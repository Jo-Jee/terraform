variable "k8s_vpc_cidr_block" {
  description = "CIDR for k8s cluster VPC"
}

variable "k8s_public_subnets_cidr" {
  description = "CIDR for k8s public subnets"
  type = list(string)
}