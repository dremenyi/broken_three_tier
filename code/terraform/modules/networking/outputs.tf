output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "vpc_cidr" {
  value = aws_vpc.vpc.cidr_block
}

output "vpc_public_subnets" {
  # Result is a map of subnet id to cidr block, e.g.
  # { "subnet_1234" => "10.0.1.0/4", ...}
  value = {
    for subnet in aws_subnet.public :
    subnet.id => subnet.cidr_block
  }
}

output "vpc_public_subnets_ids" {
  # Result is a map of subnet id to cidr block, e.g.
  # { "subnet_1234" => "10.0.1.0/4", ...}
  value = {
    for subnet in aws_subnet.public :
    subnet.cidr_block => subnet.id
  }
}

output "vpc_private_subnets" {
  # Result is a map of subnet id to cidr block, e.g.
  # { "subnet_1234" => "10.0.1.0/4", ...}
  value = {
    for subnet in aws_subnet.private :
    subnet.id => subnet.cidr_block
  }
}

output "vpc_private_subnet_Ids" {
  # Result is a map of subnet id to cidr block, e.g.
  # { "subnet_1234" => "10.0.1.0/4", ...}
  value = {
    for subnet in aws_subnet.private :
    subnet.cidr_block => subnet.id
  }
}
/*
output "vpc_subnet_ips"{
  value = {
    for sub in aws_subnet.private : subnet.id => subnet.id
  }
}
*/
/*
output "nat_eips" {
  value = {
    for eip in aws_eip.nat : 
    eip.id => nat_eip_ids
 }
}
*/

/*
output "prod_vpc_id" {
  value = aws_vpc.prod_vpc.id
}

output "public_subnet_id" {
  value = aws_subnet.public-subnet.id
}

output "private_subnet_id" {
  value = aws_subnet.private-subnet.id
}

output "gw_id" {
  value = aws_internet_gateway.gw.id
}

output "public_rt_id" {
  value = aws_route_table.public-rt.id
}
/*
output "public_sg_id" {
  value = aws_security_group.publicsg.id
}

output "private_sg_id" {
  value = aws_security_group.privatesg.id
}
*/



