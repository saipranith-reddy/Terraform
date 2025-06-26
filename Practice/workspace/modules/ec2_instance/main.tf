provider "aws" {
    region = "ap-southeast-1"  
}
variable "ami" {
    description = "To select AMI."
}
variable "instance_type" {
    description = "To select instance type."
  
}
variable "subnet_id" {
    description = "To provide subnet Id value" 
    type = string
}
resource "aws_instance" "ec2" {
    ami = var.ami
    subnet_id = var.subnet_id
    key_name = "Load Balancer"
    instance_type = var.instance_type
    tags = {
    Name        = "TerraformEC2"   
  }
}
