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
variable "ami_id"{
  description = "This is provide value of ami"
  type = string
}
variable "subnet_id"{
  description = "To provide the susbnet id value."
  type = string
}