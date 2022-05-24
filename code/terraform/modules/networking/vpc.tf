

resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name        = "cf-${var.infra_env}-vpc"
    Project     = "cf.io"
    Environment = var.infra_env
    ManagedBy   = "terraform"
  }
}

# Create 1 public subnets for each AZ within the regional VPC
resource "aws_subnet" "public" {
  for_each = var.public_subnet_numbers

  vpc_id            = aws_vpc.vpc.id
  availability_zone = each.key

  # 2,048 IP addresses each
  cidr_block = cidrsubnet(aws_vpc.vpc.cidr_block, 8, each.value)

  tags = {
    Name        = "cf-${var.infra_env}-public-subnet-${each.key}"
    Project     = "cf.io"
    Role        = "public"
    Environment = var.infra_env
    ManagedBy   = "terraform"
    Subnet      = "${each.key}-${each.value}"
  }
}

# Create 1 private subnets for each AZ within the regional VPC
resource "aws_subnet" "private" {
  for_each = var.private_subnet_numbers

  vpc_id            = aws_vpc.vpc.id
  availability_zone = each.key

  # 2,048 IP addresses each
  cidr_block = cidrsubnet(aws_vpc.vpc.cidr_block, 8, each.value)

  tags = {
    Name        = "cf-${var.infra_env}-private-subnet-${each.key}"
    Project     = "cf.io"
    Role        = "private"
    Environment = var.infra_env
    ManagedBy   = "terraform"
    Subnet      = "${each.key}-${each.value}"
  }
}

resource "aws_subnet" "database_subnets" {
  for_each = var.database_subnet_numbers

  vpc_id            = aws_vpc.vpc.id
  availability_zone = each.key

  # X IP addresses each
  cidr_block = cidrsubnet(aws_vpc.vpc.cidr_block, 8, each.value)

  tags = {
    Name        = "cf-${var.infra_env}-database-subnet-${each.key}"
    Project     = "cf.io"
    Role        = "private"
    Environment = var.infra_env
    ManagedBy   = "terraform"
    Subnet      = "${each.key}-${each.value}"
  }
}









/*
// defines the vpc - variable passed from variables.tf
resource "aws_vpc" "prod_vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  tags = {}
}

// Define the public subnet within the production VPC

resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.prod_vpc.id
  cidr_block        = var.public_subnet_cidr
  tags = {}
}

// Define the private subnet within the production VPC
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.prod_vpc.id
  cidr_block        = var.private_subnet_cidr
  tags = {}

}

resource "aws_subnet" "database_subnet" {
  vpc_id = aws_vpc.prod_vpc.id
  cidr_block = var.database_subnet_cidr
  tags = {}
}

// Define the Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.prod_vpc.id
  tags = {}
}

// Define the route table
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.prod_vpc.id


  route {
    // Talk to the Internetz
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {}

}


// Assign the route table to the public subnet

resource "aws_route_table_association" "public-rt" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.public-rt.id

}

*/