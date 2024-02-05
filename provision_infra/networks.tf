# Create a VPC with a /16 CIDR block
resource "aws_vpc" "tf-vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "tf-${var.environment}-vpc"
  }
}

/* Elastic IP for NAT */
resource "aws_eip" "nat_eip" {
  depends_on = [aws_internet_gateway.ig]
}

/* NAT Gateway */
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.tf-public-subnet.id
  depends_on    = [aws_internet_gateway.ig]
  tags = {
    Name = "tf-${var.environment}-gw-nat"
  }
}

resource "aws_subnet" "tf-public-subnet" {
  vpc_id                  = aws_vpc.tf-vpc.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = var.availability_zone_1
  map_public_ip_on_launch = true
  tags = {
    Name = "tf-${var.environment}-public-subnet"
  }
}

resource "aws_subnet" "tf-private-subnet" {
  vpc_id                  = aws_vpc.tf-vpc.id
  cidr_block              = var.private_subnet_cidr
  availability_zone       = var.availability_zone_2
  map_public_ip_on_launch = false
  tags = {
    Name = "tf-${var.environment}-private-subnet"
  }
}

/* Internet gateway for the public subnet */
resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.tf-vpc.id
  tags = {
    Name = "tf-${var.environment}-igw"
  }
}

/* Route table for the public subnet */
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.tf-vpc.id
  tags = {
    Name = "tf-${var.environment}-rt-private"
  }
}

/* Route table for the private subnet */
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.tf-vpc.id
  tags = {
    Name = "tf-${var.environment}-rt-public"
  }
}

/* Route for the public subnet */
resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  gateway_id             = aws_internet_gateway.ig.id
  destination_cidr_block = "0.0.0.0/0"
}

/* Route for the private subnet */
resource "aws_route" "private_nat_gateway" {
  route_table_id         = aws_route_table.private.id
  nat_gateway_id         = aws_nat_gateway.nat.id
  destination_cidr_block = "0.0.0.0/0"
}

/* Associate the public subnet with the public route table */
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.tf-public-subnet.id
  route_table_id = aws_route_table.public.id
}

/* Associate the private subnet with the private route table */
resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.tf-private-subnet.id
  route_table_id = aws_route_table.private.id
}