# openvpn
Creates OpenVPN conifguration for AWS with required VPC. 
_________________________________

Single VPC OpenVPN Configuration
_________________________________

Create VPC


10.200.240.0/22 VPC

10.200.240.1 - 10.200.243.254 - Usable 


Create Subnets Reserving one for VPN Clients

10.200.240.1 - 10.200.240.254 - Public Subnet 

10.200.241.1 - 10.200.241.254 - Private Subnet

10.200.242.1 - 10.200.242.254 - VPN Clients (doesn't need to be on AWS, just kept aside for OVPN Dynamic Clients)

Create Internet Gateway and attach it to VPC 

Add route to Route Table For Public VPC 

0.0.0.0/0 to Internet Gateway 

Create NAT Gateway assign it a Elastic IP and attach it to Private-Subnet 

Create Private-Route-Table 

Set 0.0.0.0/0 to nat-gateway and associate private subnet with private-route-table 


Create EC2 Security Group, Allow All Traffic From VPN Client Subnet Allow-All-Inbound-OpenVPN-Traffic

Use the OpenVPN ami to configure an EC2 instance, ensure it's configured in the Public Subnet ami-0f6f5a74e666160bb with the name Open-VPN-Server

Use the Default Security Groups that come with the AMI 

Configure an Elastic IP from Amazons pool and associate it with the Open-VPN-Server and edit the Elastic IP Name as Open-VPN-Server

Configure The Auto-Setup, use all default options 

Navigate to the Public IP Admin example: https://54.73.158.8:943/admin/ 

Go to Config > VPN Settings 

Change Network Address to 10.200.242.0/24 leave static blank. 

group default needs to also be the same 

configure routing to 

10.200.241.0/24 (Private-Subnet)

Create Security Group to allow all traffic from 10.200.240.0/24 (Public Subnet) 

Create a test EC2 instance in the Private Subnet and test connectivity on OpenVPN Client


download the config from the UI page

Example: https://54.73.158.8:943/
