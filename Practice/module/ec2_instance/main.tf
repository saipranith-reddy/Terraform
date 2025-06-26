provider "aws" {
  region = "us-east-1"  # Set your desired AWS region
}
resource "aws_instance" "my_EC2" {
    ami = var.ami_id
    instance_type = var.EC2_Type
    subnet_id = var.subnet_id   
    tags = {
    Name        = "ModuleEC2"   
 }
}