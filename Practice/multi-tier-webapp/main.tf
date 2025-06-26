provider "aws" {
  region = var.region
}

module "vpc" {
source = "./modules/vpc"
  region = "us-east-1" # to override default value in modules/vpc/variables.tf
}
module "app" {
source = "./modules/app"
  security_group_id = module.vpc.allow_tls_sg_id
  vpc_id=module.vpc.vpc_id
  ami_id=var.ami_id
  subnets=module.vpc.subnets
}
module "db" {
    source = "./modules/db"
    subnet_ids=module.vpc.pvtsub 
}