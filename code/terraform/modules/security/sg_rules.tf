
resource "aws_security_group" "publicsg" {
  name        = "Public_Subnet_Security_Group"
  description = "Allowed Ingress Traffic for Public Subnet"
  vpc_id = data.terraform_remote_state.networking.outputs.prod_vpc_id
}


/*
resource "aws_security_group_rule" "allow_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.publicsg.id

}

resource "aws_security_group_rule" "allow_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.publicsg.id

}


resource "aws_security_group_rule" "allow_ssh_from_all" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.publicsg.id

}

resource "aws_security_group_rule" "allow_icmp_ping" {
  type              = "ingress"
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.publicsg.id

}

resource "aws_security_group_rule" "allow_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.publicsg.id
}

// Define the security group for the private subnet
resource "aws_security_group" "privatesg" {
  name        = "Private_Subnet_Security_Group"
  description = "Default security group for the private subnet"
  vpc_id      = aws_vpc.prod_vpc.id
}

resource "aws_security_group_rule" "allow_3306" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  cidr_blocks       = [var.public_subnet_cidr]
  security_group_id = aws_security_group.privatesg.id
}

resource "aws_security_group_rule" "allow_icmp_from_pub" {
  type              = "ingress"
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  cidr_blocks       = [var.public_subnet_cidr]
  security_group_id = aws_security_group.privatesg.id
}

resource "aws_security_group_rule" "allow_ssh_from_pub" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [var.public_subnet_cidr]
  security_group_id = aws_security_group.privatesg.id
}
*/