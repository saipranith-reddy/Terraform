provider "aws" {
  alias  = "us-east-1"  
  region = "us-east-1"  # Set your desired AWS region
}
provider "aws"{
  alias  = "ap-south-1"  
  region = "ap-south-1"
}
provider "aws" {
  alias  = "ap-southeast-1"
  region = "ap-southeast-1"
}
variable "aws_region" {
  description = "To select the region"
  type        = string
  default     = "ap-southeast-1"
}
variable "EC2_Type" {
  description = "This provides the type of instance we are using."
  type = string
  default = "t2.micro" #EC2_Type = "t3.nano" when written in .tfvars files terraform apply -var-file="myvars.tfvars"
}
resource "aws_instance" "EC2" {
  ami                    = "ami-020cba7c55df1f615"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["sg-061374c5857ff8923"]
  subnet_id              = "subnet-0797a64972604a5ac"
  provider               = "aws.us-east-1"
  tags = {
    Name        = "TerraformEC2"   
  }
}
resource "aws_instance" "my_EC2" {
    ami = "ami-0f918f7e67a3323f0"
    instance_type = "t2.micro"
    provider = "aws.ap-south-1"
    tags = {
    Name        = "TerraformEC2"   
 }
}
resource "aws_instance" "singapore_EC2" {
    count= var.aws_region == "ap-southeast-1" ? 1:0 #creates EC2 if -var="aws_region=ap-southeast-1" is passed OR when default value is present.
    ami = "ami-02c7683e4ca3ebf58"
    instance_type = var.EC2_Type # -var="EC2_Type=t2.nano" OR Considers Default value
    subnet_id = "subnet-0db0a3b8f13e5616c"
    vpc_security_group_ids = ["sg-0c6dbbbc2b4405adc"]
    provider =  "aws.ap-southeast-1"
    tags = {
    Name        = "TerraformEC2"   
 } #terraform plan -target="aws_instance.singapore_EC2" -var="EC2_Type=t2.nano" -var="aws_region=ap-southeast-1"
}
output "public_ip" {
  description = "Public IP addresses of all EC2 instances"
  value = {
    mumbai_EC2    = try(aws_instance.my_EC2.public_ip, "not created")
    Virginia_EC2  = try(aws_instance.EC2.public_ip, "not created")
    singapore_EC2 = try(aws_instance.singapore_EC2[0].public_ip, "not created")
  }
}