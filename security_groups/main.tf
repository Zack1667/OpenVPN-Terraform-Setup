provider "aws" {
  region = var.aws_region
  profile = var.aws_profile
}

resource "aws_security_group" "vpn_server" {
  name   = "VPN-Server-SG"
  description = "Default-OpenVPN-Rules"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 943
    to_port     = 943
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Can be limited to a group of public IP's or Corporate Public IPs 
  }
    ingress {
    from_port   = 945
    to_port     = 945
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Can be limited to a group of public IP's or Corporate Public IPs 
  }

  ingress {
    from_port   = 1194
    to_port     = 1194
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"] # Can be limited to a group of public IP's or Corporate Public IPs 
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Can be limited to a group of public IP's or Corporate Public IPs 
  }
    ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Can be limited to a group of public IP's or Corporate Public IPs 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_security_group" "allow_inbound_vpn_pub" {
  name   = "Allow-Inbound-From-VPN-Public"
  description = "Allow-Public-And-VPN-Subnet"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["10.200.240.0/24"] # Change to 172.20.0.0/24 if using Class B CIDR
  
  }
  
  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["10.200.242.0/24"] # Change to 172.20.2.0/24 if using Class B CIDR
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.200.240.0/24"] # Change to 172.20.0.0/24 if using Class B CIDR
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.200.242.0/24"]  # Change to 172.20.2.0/24 if using Class B CIDR
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}