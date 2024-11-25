output "vpn_server_public_ip" { # Outputs the Public IP Address of the OpenVPN server
  value = module.ec2.elastic_ip
}
