output "public_subnet_id" {
  value = aws_subnet.public.id
}

output "vpc_main_id" {
  value = aws_vpc.main.id
}

output "shared_sg_id" {
  value = aws_security_group.shared_sg.id
}