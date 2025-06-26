provider "aws" {
    region = "ap-southeast-1"  
}
variable "ami" {
    description = "To select AMI."
}
variable "subnet_id" {
    description = "To provide subnet Id value" 
    type = string
}
variable "instance_type" {
    description = "To select Instance type."  
    type = map(string)
     default = {
        dev="t2.micro"
        stage="t2.nano"
        prod="t2.large"
  }
}
module "ec2_instance" {
    source = "./modules/ec2_instance"
    ami=var.ami
    subnet_id = var.subnet_id
    instance_type=lookup(var.instance_type,terraform.workspace,"t2.micro")      
}