provider "aws" {
    region = "us-east-1"
}
resource "aws_vpc" "main" {
  cidr_block = "20.0.0.0/16"
  tags = {
    Name = "Terra"
  }
}
resource "aws_key_pair" "terraform" {
  key_name   = "terraform-key"
  public_key = file("C:/Users/SAI PRANITH/.ssh/id_rsa.pub")
}
resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "20.0.1.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "pubsub"
  }
}
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "main"
  }
}
resource "aws_route_table" "publicRT" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "publicRT"
  }
}
resource "aws_main_route_table_association" "a" {
  vpc_id         = aws_vpc.main.id
  route_table_id = aws_route_table.publicRT.id
}
resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.main.id

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
resource "aws_instance" "server" {
  ami           = "ami-020cba7c55df1f615"
  instance_type = "t2.micro"
  key_name = aws_key_pair.terraform.key_name
  vpc_security_group_ids = [aws_security_group.allow_tls.id]  
  subnet_id = aws_subnet.main.id
  tags = {
    Name = "terraEC2"
  }
   provisioner "local-exec" {
    command = "echo The server's IP address is ${self.private_ip}"
  }
  connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = file("C:/Users/SAI PRANITH/.ssh/id_rsa")
    host     = self.public_ip
  }

  # File provisioner to copy a file from local to the remote EC2 instance
  provisioner "file" {
    source      = "C:/Users/SAI PRANITH/Desktop/new.txt"  # Replace with the path to your local file
    destination = "/home/ubuntu/new.txt"  # Replace with the path on the remote instance
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Hello from the remote instance'",
      "sudo apt update -y",  # Update package lists (for ubuntu)
      "sudo apt-get install -y nginx",
    ]
  }
}