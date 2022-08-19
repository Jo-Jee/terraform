resource "aws_security_group" "k8s-sg" {
  name = "k8s-sg"
  vpc_id = aws_vpc.k8s-vpc.id

  tags = {
    "Name" = "k8s-sg"
  }
}

resource "aws_security_group_rule" "allow-ingress-each" {
  type = "ingress"
  from_port = 0
  to_port = 65535
  protocol = "all"
  self = true
  security_group_id = aws_security_group.k8s-sg.id
}

resource "aws_security_group_rule" "allow-egress" {
  type = "egress"
  from_port = 0
  to_port = 65535
  protocol = "all"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.k8s-sg.id
}

resource "aws_security_group_rule" "allow-ssh" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.k8s-sg.id
}

resource "aws_instance" "k8s-master" {
  ami = "ami-058165de3b7202099"
  instance_type = "t2.micro"

  count = var.k8s_master_num

  subnet_id = element(aws_subnet.k8s-public-subnets.*.id, count.index)

  vpc_security_group_ids = [aws_security_group.k8s-sg.id]

  key_name = var.AWS_SSH_KEY_NAME

  tags = {
    "Name" = "k8s-master-${count.index}"
  }
}
