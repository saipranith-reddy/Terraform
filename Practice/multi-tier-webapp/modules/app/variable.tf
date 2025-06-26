variable "security_group_id" {
    description = "To provide the securoty group id."
    type = string  
}
variable "vpc_id" {
    description = "to provide vpc id."
    type = string  
}
variable "ami_id" {
  type = string
}
variable "subnets" {
    type = list(string)
}