# CREATES VPC

resource "aws_vpc" "aws_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "aws_vpc"
  }
}

resource "aws_subnet" "aws_subnet_public" {
  vpc_id = aws_vpc.aws_vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "aws_subnet_public"
  }
}

resource "aws_subnet" "aws_subnet_private" {
  vpc_id = aws_vpc.aws_vpc.id
  cidr_block = "10.0.2.0/24"
  tags = {
    Name = "aws_subnet_private"
  }
}

resource "aws_internet_gateway" "aws_internet_gateway" {
  vpc_id = aws_vpc.aws_vpc.id
  tags = {
    Name = "aws_internet_gateway"
  }
}

resource "aws_route_table" "aws_route_table" {
  vpc_id = aws_vpc.aws_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.aws_internet_gateway.id
  }
  tags = {
    Name = "aws_route_table"
  }
}

resource "aws_route_table_association" "aws_route_table_association" {
  route_table_id = aws_route_table.aws_route_table.id
  subnet_id = aws_subnet.aws_subnet_public.id
}
