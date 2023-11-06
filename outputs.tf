output "gateway_ip_addr" {
  value = aws_instance.gateway.public_ip
}
