variable "public_subnet_numbers" {
  type = map(number)

  description = "Map of AZ to a number that should be used for public subnets"

  default = {
    "us-east-2a" = 0
    "us-east-2b" = 1
    #"us-east-1c" = 3
  }
}

variable "private_subnet_numbers" {
  type = map(number)

  description = "Map of AZ to a number that should be used for private subnets"

  default = {
    "us-east-2a" = 2
    "us-east-2b" = 3
    #"us-east-1c" = 6
  }
}

variable "database_subnet_numbers" {
  type = map(number)

  description = "Map of AZ to a number that should be used for private subnets"

  default = {
    "us-east-2a" = 4
    "us-east-2b" = 5
    #"us-east-1c" = 6
  }
}

variable "vpc_cidr" {
  type        = string
  description = "The IP range to use for the VPC"
  default     = "192.168.0.0/16"
}

variable "infra_env" {
  type        = string
  description = "infrastructure environment"
  default     = "test"
}



/*
// define the VPC configurations for public and private subnets within the production VPC \\
variable "vpc_cidr" {
  description = "VPC For Production"
  type = string
  
}

variable "public_subnet_cidr" {
  description = "CIDR for the public subnet"
  type = string
}

variable "private_subnet_cidr" {

  description = "Cidr for the private subnet"
  type = string
}

variable "database_subnet_cidr" {
  description = "subnet block for the subnet cidr"
  type = string
}

variable "instance_type" {
  default = "t2.micro"
  type = string
}

*/



