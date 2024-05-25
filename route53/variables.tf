variable "aws_region" {
  description = "The AWS region to create resources in"
  type        = string
  default     = "eu-west-1"
}

variable "domain_name" {
  description = "The domain name for the Route 53 hosted zone"
  type        = string
}

variable "environment" {
  description = "The environment tag for the Route 53 hosted zone"
  type        = string
  default     = "production"
}
