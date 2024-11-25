variable "vpc_cidr" {}
variable "public_subnet_cidr" {}
variable "private_subnet_cidr" {}
variable "vpn_client_subnet_cidr" {}
variable "aws_profile" {
  description = "AWS Profile for SSO"
  type        = string
}
variable "aws_region" {
  description = "The AWS region to deploy resources in."
  type        = string
  default     = "eu-west-1"
}