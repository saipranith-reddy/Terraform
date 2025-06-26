output "vpc_id" {
  value = aws_vpc.multi.id
}

output "subnets" {
  value = [
    aws_subnet.public.id,
    aws_subnet.public1.id
  ]
}
output "allow_tls_sg_id" {
  value = aws_security_group.allow_tls.id
}
output "pvtsub" {
   value = [
    aws_subnet.private2.id,
    aws_subnet.private1.id
  ]
}

