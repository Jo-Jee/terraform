resource "aws_vpc" "k8s-vpc" {
  cidr_block = var.k8s_vpc_cidr_block

  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    "Name" = "k8s-vpc"
  }
}

resource "aws_subnet" "k8s-public-subnets" {
  vpc_id = aws_vpc.k8s-vpc.id
  count = length(var.k8s_public_subnets_cidr)
  availability_zone = element(var.aws_az, count.index % length(var.aws_az))
  cidr_block = element(var.k8s_public_subnets_cidr, count.index)
  map_public_ip_on_launch = true

  tags = {
    "Name" = "k8s-pub-${substr(element(var.aws_az, count.index), -1, -1)}"
  }
}

resource "aws_internet_gateway" "k8s-igw" {
  vpc_id = aws_vpc.k8s-vpc.id

  tags = {
    "Name" = "k8s-igw"
  }
}

resource "aws_route_table" "k8s-public-rt" {
  vpc_id = aws_vpc.k8s-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.k8s-igw.id
  }

  tags = {
    "Name" = "k8s-pub-rt"
  }
}

resource "aws_route_table_association" "k8s-public-rt-association" {
  count = length(var.k8s_public_subnets_cidr)
  subnet_id = element(aws_subnet.k8s-public-subnets.*.id, count.index)
  route_table_id = aws_route_table.k8s-public-rt.id
}
