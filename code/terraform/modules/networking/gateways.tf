###
# IGW and NGW
##
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "cf-${var.infra_env}-vpc"
    Project     = "cf.io"
    Environment = var.infra_env
    VPC         = aws_vpc.vpc.id
    ManagedBy   = "terraform"
  }
}

resource "aws_eip" "nat" {
  for_each = var.private_subnet_numbers
  vpc      = true

  lifecycle {
    # prevent_destroy = true
  }

  tags = {
    Name        = "cf-${var.infra_env}-eip"
    Project     = "cf.io"
    Environment = var.infra_env
    VPC         = aws_vpc.vpc.id
    ManagedBy   = "terraform"
    Role        = "private"
  }
}

# Note: We're only creating one NAT Gateway, potential single point of failure
# Each NGW has a base cost per hour to run, roughly $32/mo per NGW. You'll often see
#  one NGW per AZ created, and sometimes one per subnet.
# Note: Cross-AZ bandwidth is an extra charge, so having a NAT per AZ could be cheaper
#        than a single NGW depending on your usage

resource "aws_nat_gateway" "ngw" {
  for_each      = var.private_subnet_numbers
  subnet_id     = aws_subnet.public[each.key].id
  allocation_id = aws_eip.nat[each.key].id
  #allocation_id = data.outputs.nat_eips.*.id
  #content  = "${element(aws_eip.nat.*.id, count.index)}"
  #count = length(aws_eip.nat)

  # Whichever the first public subnet happens to be
  # (because NGW needs to be on a public subnet with an IGW)
  # keys(): https://www.terraform.io/docs/configuration/functions/keys.html
  # element(): https://www.terraform.io/docs/configuration/functions/element.html

  #allocation_id = aws_eip.nat[each.key].id

  tags = {
    Name        = "cf-${var.infra_env}-ngw"
    Project     = "cf.io"
    VPC         = aws_vpc.vpc.id
    Environment = var.infra_env
    ManagedBy   = "terraform"
    Role        = "private"
  }
}


###
# Route Tables, Routes and Associations
##

# Public Route Table (Subnets with IGW)
resource "aws_route_table" "public" {
  for_each = var.public_subnet_numbers
  vpc_id   = aws_vpc.vpc.id

  tags = {
    Name        = "cf-${var.infra_env}-public-rt"
    Environment = var.infra_env
    Project     = "cf.io"
    Role        = "public"
    VPC         = aws_vpc.vpc.id
    ManagedBy   = "terraform"
  }
}

# Private Route Tables (Subnets with NGW)
resource "aws_route_table" "private" {
  for_each = var.private_subnet_numbers
  vpc_id   = aws_vpc.vpc.id

  tags = {
    Name        = "cf-${var.infra_env}-private-rt"
    Environment = var.infra_env
    Project     = "cf.io"
    Role        = "private"
    VPC         = aws_vpc.vpc.id
    ManagedBy   = "terraform"
  }
}


# Public Route
resource "aws_route" "public_az1" {
  for_each               = aws_route_table.public
  route_table_id         = aws_route_table.public[each.key].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route" "public_az2" {
  for_each               = aws_route_table.private
  route_table_id         = aws_route_table.public[each.key].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# Private Route
resource "aws_route" "private_az1" {
  route_table_id         = aws_route_table.private[each.key].id
  destination_cidr_block = "0.0.0.0/0"
  for_each               = aws_nat_gateway.ngw
  nat_gateway_id         = aws_nat_gateway.ngw[each.key].id #aws_nat_gateway.ngw.id
}


# Public Route to Public Route Table for Public Subnets
resource "aws_route_table_association" "public_az1" {
  for_each  = aws_subnet.public
  subnet_id = aws_subnet.public[each.key].id
  #subnet_id = aws_subnet.public[0].id

  route_table_id = aws_route_table.public[each.key].id
}

resource "aws_route_table_association" "public_az2" {
  for_each  = aws_subnet.public
  subnet_id = aws_subnet.public[each.key].id
  #subnet_id = aws_subnet.public[1].id

  route_table_id = aws_route_table.public[each.key].id
}


# Private Route to Private Route Table for Private Subnets
resource "aws_route_table_association" "private_az1" {
  for_each  = aws_subnet.private
  subnet_id = aws_subnet.private[each.key].id
  #subnet_id = aws_subnet.public[0].id
  route_table_id = aws_route_table.private[each.key].id
}