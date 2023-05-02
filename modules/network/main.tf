# Create the VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  tags = {
    Name        = "${var.app_name}-${var.app_environment}-vpc"
    Environment = var.app_environment
  }
}

# Define the public subnet
resource "aws_subnet" "public-subnet" {
  vpc_id                  = aws_vpc.vpc.id
  count                   = length(var.public_subnet_cidr)
  cidr_block              = element(var.public_subnet_cidr, count.index)
  availability_zone       = element(var.aws_az, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.app_name}-${var.app_environment}-${element(var.aws_az, count.index)}-subnet-public"
    Environment = var.app_environment
  }
}

# Define the private subnet
resource "aws_subnet" "private-subnet" {
  vpc_id                  = aws_vpc.vpc.id
  count                   = length(var.private_subnet_cidr)
  cidr_block              = element(var.private_subnet_cidr, count.index)
  availability_zone       = element(var.aws_az, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.app_name}-${var.app_environment}-${element(var.aws_az, count.index)}-subnet-public"
    Environment = var.app_environment
  }
}


# Define the internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name        = "${var.app_name}-${var.app_environment}-gw"
    Environment = var.app_environment
  }
}

# Elastic IP for NAT
resource "aws_eip" "nat_eip" {
  vpc        = true
  depends_on = [aws_internet_gateway.gw]
}

# NAT
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = element(aws_subnet.public-subnet.*.id, 0)
  depends_on    = [aws_internet_gateway.gw]

  tags = {
    Name        = "${var.app_name}-${var.app_environment}-nat"
    Environment = var.app_environment
  }
}

# Define the public route table
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "${var.app_name}-${var.app_environment}-public"
    Environment = var.app_environment
  }
}

# Define the private route table
resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "${var.app_name}-${var.app_environment}-rtb-private"
    Environment = var.app_environment
  }
}

# Public internet gateway
resource "aws_route" "public-internet-gateway" {
  route_table_id         = aws_route_table.public-rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

# Private NAT gateway
resource "aws_route" "private-nat-gateway" {
  route_table_id         = aws_route_table.private-rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}

# Assign the public route table to the public subnet
resource "aws_route_table_association" "public-rt-association" {
  count          = length(var.public_subnet_cidr)
  subnet_id      = element(aws_subnet.public-subnet.*.id, count.index)
  route_table_id = aws_route_table.public-rt.id
}

# Assign the private route table to the private subnet
resource "aws_route_table_association" "private-rt-association" {
  count          = length(var.private_subnet_cidr)
  subnet_id      = element(aws_subnet.private-subnet.*.id, count.index)
  route_table_id = aws_route_table.private-rt.id
}

/*==== VPC's Default Security Group ======*/
resource "aws_security_group" "default" {
  name        = var.app_environment
  description = "Default security group to allow inbound/outbound from the VPC"
  vpc_id      = aws_vpc.vpc.id
  depends_on  = [aws_vpc.vpc]
  ingress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = true
  }

  egress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = "true"
  }

  tags = {
    Name        = "${var.app_name}-${var.app_environment}"
    Environment = var.app_environment
  }
}
