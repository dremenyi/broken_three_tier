
//define the region
variable "aws_region" {

  description = "Region for the VPC"
  default     = "us-east-1"

}
/*
variable "subnet_cidrs" {
  type = list
  default = ["10.1.2.0/24","10.1.3.0/24"]
}
*/
/*
variable "vpc_id" {
  type = string
  description = "The VPC ID"
}


variable "subnet_id" {
  type = string
  description = "A subnet ID..."
}
*/
variable subnet {
  type = string
}




variable "infra_env" {
  type        = string
  description = "infrastructure environment"
  default = "test"
}

//define the VPC configurations for public and private subnets within the production VPC
variable "vpc_cidr" {
  description = "VPC For Production"
  default     = "10.0.0.0/16"
}
/*
variable "public_subnet_cidr" {
  description = "CIDR for the public subnet"
  #default     = "10.0.1.0/24"
}
*/

variable "instance_type" { }
variable "root_ebs_size" {}



