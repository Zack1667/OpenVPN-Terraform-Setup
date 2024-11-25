variable "ami_id" {}
variable "instance_type" {}
variable "public_subnet_id" {}
variable "key_name" {
  description = "Name of the key pair to create"
  type        = string
  default     = "dynamic-key-pair"
}
variable "security_group_ids" {
  type = list(string)
}
variable "aws_profile" {
  description = "AWS Profile for SSO"
  type        = string
}
variable "aws_region" {
  description = "The AWS region to deploy resources in."
  type        = string
  default     = "eu-west-1"
}