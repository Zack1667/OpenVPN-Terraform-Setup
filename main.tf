provider "aws" {
  region  = var.aws_region  # default region 
  profile = var.aws_profile # aws profile used for sso, must be added to terraform.tfvars 
}

module "vpc" { # Calls the VPC module to create VPC and it's Subnets, CIDR ranges passed as variables
  source                 = "./vpc"
  vpc_cidr               = "10.200.240.0/22" # Change to Whatever /22 you like, I've done it like this as it's easier to break down
  public_subnet_cidr     = "10.200.240.0/24" # Public Subnet that has access to an Internet Gateway, OVPN Server must be deployed here
  private_subnet_cidr    = "10.200.241.0/24" # The Private Subnet with NAT Gateway Configured, Very Strict And Not Open To Public Internet
  vpn_client_subnet_cidr = "10.200.242.0/24" # The VPN Subnet you will configure in OpenVPN later to give Dynamic IP's to clients

  # spare subnet = 10.200.243.0/24 - reserved for anything you like 


  # Please use the below if there is a requirement for Class B CIDR 

  # vpc_cidr                = "172.20.0.0/22" # Change to Whatever /22 you like, I've done it like this as it's easier to break down
  # public_subnet_cidr      = "172.20.0.0/24" # Spare subnet or you can assign these as you prefer
  # private_subnet_cidr     = "172.20.1.0/24" # Public Subnet that has access to an Internet Gateway, OVPN Server must be deployed here
  # vpn_client_subnet_cidr  = "172.20.2.0/24" # The Private Subnet with NAT Gateway Configured, Very Strict And Not Open To Public Internet
  # spare_subnet            = "172.20.3.0/24" # The VPN Subnet you will configure in OpenVPN later to give Dynamic IP's to clients
  aws_profile = var.aws_profile # Pass the profile from terraform.tfvars to module
}

module "security_groups" { # Calls the security_groups module, passing the VPC ID and the VPN client subnets CIDR block, defines security groups for OpenVPN server.
  source          = "./security_groups"
  vpc_id          = module.vpc.vpc_id
  vpn_client_cidr = "10.200.242.0/24"
  aws_profile     = var.aws_profile
}

module "ec2" {
  source             = "./ec2" # Deploys an EC2 instance using the OpenVPN AMI - The EC2 is assigned a public subnet with it's security group attached
  public_subnet_id   = module.vpc.public_subnet_id
  ami_id             = "ami-0f6f5a74e666160bb"
  instance_type      = "t3.micro"
  security_group_ids = [module.security_groups.vpn_server_sg_id]
  aws_profile        = var.aws_profile

}

# Created by Zack Goodger Cloud Engineer - For template use within Lucy Group Ltd 
