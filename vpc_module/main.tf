terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
# Creates a VPC.
resource "aws_vpc" "us_east_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name     = "us_east"
    Location = "east_us"
  }
}
//creates a private subnet. repeat code for another subnet.
resource "aws_subnet" "private_subnet1" {
  vpc_id     = aws_vpc.us_east_vpc.id
  count      = length(var.private_cidr)
  cidr_block = var.private_cidr[count.index]

  map_public_ip_on_launch = false
  tags = {
    Name = "east_private_subnet1"
  }
}
#creates a public subnet. repeat code for more.
resource "aws_subnet" "public_subnet1" {
  vpc_id                  = aws_vpc.us_east_vpc.id
  cidr_block              = element(var.public_cidr, 0)
  map_public_ip_on_launch = false
  tags = {
    Name = "east_public_subnet1"
  }
}
#I want to keep these disassociated with nat gateway.
resource "aws_subnet" "public_subnet2" {
  vpc_id                  = aws_vpc.us_east_vpc.id
  cidr_block              = element(var.public_cidr, 1)
  map_public_ip_on_launch = false
  tags = {
    Name = "east_public_subnet1"
  }
}

/* Routing table for private subnet */
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.us_east_vpc.id
  tags = {
    Name = "private-east-rt"
  }
}
/* Routing table for public subnet */
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.us_east_vpc.id
  tags = {
    Name = "public-east-rt"
  }
}
/* Route table associations */
resource "aws_route_table_association" "public1" {
  subnet_id      = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "public2" {
  subnet_id      = aws_subnet.public_subnet2.id
  route_table_id = aws_route_table.public.id
}
#made a second association for the separate public value.
resource "aws_route_table_association" "private2" {
  count          = length(var.private_cidr)
  subnet_id      = aws_subnet.private_subnet1[count.index].id
  route_table_id = aws_route_table.private.id
}
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.us_east_vpc.id

  tags = {
    Name = "east-gateway"
  }
}
#Elastic IP for NAT.
resource "aws_eip" "nat_eip" {
  vpc        = true
  depends_on = [aws_internet_gateway.gw]
}
resource "aws_nat_gateway" "gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet1.id
}

