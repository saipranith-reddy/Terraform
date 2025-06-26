provider "aws" {
    region = var.region
} 
resource "aws_vpc" "multi" {
  cidr_block = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "Terramultiregion"
  }
}
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.multi.id
  tags = {
    Name = "multigw"
  }
}
resource "aws_route_table" "publicRT" {
  vpc_id = aws_vpc.multi.id 
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "MultiPUBRT"
  }
}
resource "aws_route_table" "privateRT" {
  vpc_id = aws_vpc.multi.id 
  tags = {
    Name = "MultiPVTRT"
  }
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.multi.id
  cidr_block = "30.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "pub-1a"
  }
}
resource "aws_subnet" "public1" {
  vpc_id     = aws_vpc.multi.id
  cidr_block = "30.0.10.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "pub-1b"
  }
}
resource "aws_subnet" "private1" {
  vpc_id     = aws_vpc.multi.id
  cidr_block = "30.0.2.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "pvt-1b"
  }
}
resource "aws_subnet" "private2" {
  vpc_id     = aws_vpc.multi.id
  cidr_block = "30.0.3.0/24"
  availability_zone = "us-east-1c"
  map_public_ip_on_launch = true
  tags = {
    Name = "pvt-1c"
  }
}
resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.multi.id

  tags = {
    Name = "allow_tls"
  }
}
resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.publicRT.id
}
resource "aws_route_table_association" "pub" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.publicRT.id
}
resource "aws_route_table_association" "pvt" {
  subnet_id      = aws_subnet.private1.id
  route_table_id = aws_route_table.privateRT.id
}
resource "aws_route_table_association" "pvt2" {
  subnet_id      = aws_subnet.private2.id
  route_table_id = aws_route_table.privateRT.id
}  