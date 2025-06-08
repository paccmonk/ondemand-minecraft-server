resource "tls_private_key" "pem_key" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "aws_key_pair" "minecraft_server_keypair" {
  key_name = "minecraft_server_keypair"
  public_key = tls_private_key.pem_key.public_key_openssh
  
}

resource "local_file" "minecraft_server_keypair" {
  content = tls_private_key.pem_key.private_key_pem
  filename = "${path.module}/minecraft_server_keypair.pem"
  file_permission = 0400
}
