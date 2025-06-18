provider "aws" {
  region = "us-east-1"  # Set your desired AWS region
}

resource "aws_instance" "example" {
  ami                    = "ami-09e6f87a47903347c"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["sg-061374c5857ff8923"]
  subnet_id              = "subnet-0797a64972604a5ac"

  tags = {
    Name        = "TerraformEC2"   
  }
}