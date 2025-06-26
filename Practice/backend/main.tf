provider "aws" {
    region = "ap-south-1"  
}
resource "aws_instance" "ec2" {
    instance_type = "t2.micro"
    ami = "ami-0f918f7e67a3323f0"
    subnet_id = "subnet-0fd8cc605800c4931"
}
resource "aws_s3_bucket" "s3" {
    bucket = "terrabuckpranithreddy"
     tags = {
    Name        = "Terraform bucket"
  }  
}