terraform {
  required_providers {
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
  }
}



provider "aws" {
  region = var.aws_region
  profile = var.aws_profile
}

resource "aws_instance" "vpn_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.public_subnet_id
  key_name        = aws_key_pair.this.key_name

  tags = { Name = "OpenVPN-Server" }

  security_groups = var.security_group_ids
}

resource "aws_eip" "vpn_server" {
  instance = aws_instance.vpn_server.id
  tags     = { Name = "OpenVPN-Server-EIP" }
}

resource "tls_private_key" "key_pair" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "this" {
  key_name   = "openvpn-server-key" #hardcoded name 
  public_key = tls_private_key.key_pair.public_key_openssh
}

# Save the private key to a file
resource "local_file" "private_key" {
  content  = tls_private_key.key_pair.private_key_pem
  filename = "${path.module}/generated-key.pem"
}

