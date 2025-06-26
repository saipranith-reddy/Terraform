provider "aws" {
  region = "us-east-1"  # Set your desired AWS region
}
module "ec2_instance" {
    source = "./ec2_instance"
    ami_id = "ami-020cba7c55df1f615"
    EC2_Type = "t2.micro"
    subnet_id =   "subnet-0797a64972604a5ac"   
}