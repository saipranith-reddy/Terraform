output "public_ip" {
  description = "Public IP addresses of all EC2 instances"
  value = try(aws_instance.my_EC2.public_ip, "not created")
    }