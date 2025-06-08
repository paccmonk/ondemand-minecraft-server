output "instance_public_ip" {
  value = aws_instance.minecraft_server.public_ip
}

output "tls_private_key" {
  value = tls_private_key.pem_key.private_key_pem
  sensitive = true
}