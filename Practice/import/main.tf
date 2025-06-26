provider "aws" {
    region="ap-south-1"  
}
/*import {
  id="i-0fa9ef0ac5bf048b1"
  to = aws_instance.tfbackup
}*/ # terraform plan -generate-config-out="generated_resources.tf"

  # __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

resource "aws_instance" "tfbackup" {
  ami                                  = "ami-0f918f7e67a3323f0"
  associate_public_ip_address          = true
  availability_zone                    = "ap-south-1a"
  disable_api_stop                     = false
  disable_api_termination              = false
  ebs_optimized                        = false
  enable_primary_ipv6                  = null
  get_password_data                    = false
  hibernation                          = false
  host_id                              = null
  host_resource_group_arn              = null
  iam_instance_profile                 = null
  instance_initiated_shutdown_behavior = "stop"
  instance_type                        = "t2.micro"
  key_name                             = "Windows"
  monitoring                           = false
  placement_group                      = null
  placement_partition_number           = 0
  private_ip                           = "10.0.0.94"
  region                               = "ap-south-1"
  secondary_private_ips                = []
  security_groups                      = []
  source_dest_check                    = true
  subnet_id                            = "subnet-0fd8cc605800c4931"
  tags = {
    Name = "portfolio"
  }
  tags_all = {
    Name = "portfolio"
  }
  tenancy                     = "default"
  user_data                   = "#!/bin/bash\nsudo apt update -y\nsudo apt install nginx -y"
  user_data_base64            = null
  user_data_replace_on_change = null
  volume_tags                 = null
  vpc_security_group_ids      = ["sg-0e0cef410969cfef2"]
  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }
  cpu_options {
    amd_sev_snp      = null
    core_count       = 1
    threads_per_core = 1
  }
  credit_specification {
    cpu_credits = "standard"
  }
  enclave_options {
    enabled = false
  }
  maintenance_options {
    auto_recovery = "default"
  }
  metadata_options {
    http_endpoint               = "enabled"
    http_protocol_ipv6          = "disabled"
    http_put_response_hop_limit = 2
    http_tokens                 = "required"
    instance_metadata_tags      = "disabled"
  }
  private_dns_name_options {
    enable_resource_name_dns_a_record    = false
    enable_resource_name_dns_aaaa_record = false
    hostname_type                        = "ip-name"
  }
  root_block_device {
    delete_on_termination = true
    encrypted             = false
    iops                  = 3000
    kms_key_id            = null
    tags                  = {}
    tags_all              = {}
    throughput            = 125
    volume_size           = 8
    volume_type           = "gp3"
  }
}