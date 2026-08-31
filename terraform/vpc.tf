resource "aws_vpc" "vpc-main" {
  cidr_block = "10.1.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags={
    Name = "3-tier-stack-vpc"
  }

}

resource "aws_internet_gateway" "ig-main" {
  vpc_id = aws_vpc.vpc-main.id
  tags={
    Name = "3-tier-stack-ig"
  }
}

resource "aws_subnet" "public-sub-1a" {
  vpc_id = aws_vpc.vpc-main.id
  cidr_block = "10.1.1.0/24"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = true

  tags={
    Name = "3-tier-stack-public-1a"
  }
}

resource "aws_subnet" "public-sub-1b" {
  vpc_id = aws_vpc.vpc-main.id
  cidr_block = "10.1.2.0/24"
  availability_zone = "ap-south-1b"
  map_public_ip_on_launch = true

  tags={
    Name = "3-tier-stack-public-1b"
  }
}

resource "aws_subnet" "private-sub-1a" {
  vpc_id = aws_vpc.vpc-main.id
  cidr_block = "10.1.50.0/24"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = true

  tags={
    Name = "3-tier-stack-private-1a"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc-main.id
  route{
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig-main.id
  }

  tags = {
    Name = "3-tier-stack-public-rt"
  }
}

resource "aws_route_table_association" "public_1a_assoc" {
  subnet_id      = aws_subnet.public-sub-1a.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_1b_assoc" {
  subnet_id      = aws_subnet.public-sub-1b.id
  route_table_id = aws_route_table.public_rt.id
}