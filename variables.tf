variable "aws_region" {
  description = "The AWS region to deploy resources in."
  type        = string
  default     = "eu-west-1"
}
variable "aws_profile" {
  description = "AWS Profile for SSO"
  type        = string
}
