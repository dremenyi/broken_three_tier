
provider "aws" {
  region = "us-east-2"
  #assume_role {
  #role_arn = "arn:aws:iam::${var.clientAccountId}:role/tf-mcs-2w-aws-backup-role"
}

locals {
  tags = {
    Owner       = "Koda"
    Environment = "prod"
  }
}

module "Network" {
  source   = "../terraform/modules/networking"
  vpc_cidr = "10.1.0.0/16"
}

module "wp_server1" {
  source = "../terraform/modules/compute"
  instance_type = "t3a.micro"
  root_ebs_size = "20"
  subnet = "${lookup(module.Network.vpc_private_subnets_ids,"10.1.2.0/24")}"
}

/*
module "wp_server2" {
  source = "../terraform/modules/compute"
  instance_type = "t3a.micro"
  root_ebs_size = "20"
  subnet_cidr = "10.1.3.0.24"
  
}

module "bastion1" {
  source = "../terraform/modules/compute"
  instance_type = "t3a.medium"
  root_ebs_size = "50"
  subnet_cidr = "10.1.0.0.24"
  
}
*/