variable "aws_region" {
  description = "The AWS region to create resources in"
  type        = string
}

variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "172.31.0.0/16"
}
