resource "tls_private_key" "app_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "app_key" {
  key_name   = "${var.environment}-app-key"
  public_key = tls_private_key.app_key.public_key_openssh
}

resource local_file "app_key" {
  content  = tls_private_key.app_key.private_key_pem
  filename = "${path.module}/${var.environment}-app-key.pem"
}

output "private_key_pem" {
  value     = tls_private_key.app_key.private_key_pem
  sensitive = true
}

output "key_name" {
  value = aws_key_pair.app_key.key_name
}