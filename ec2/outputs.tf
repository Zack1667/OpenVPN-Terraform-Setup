output "elastic_ip" {
  value = aws_eip.vpn_server.public_ip
  description = "Public IP address of the OpenVPN server."
}
# Ensure file permissions are secure
output "private_key_path" {
  value = local_file.private_key.filename
  description = "Path to the private key file for SSH access."
}

output "private_key" {
  value     = tls_private_key.key_pair.private_key_pem
  sensitive = true
}