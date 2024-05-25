variable "aws_region" {
  description = "The AWS region to create resources in"
  type        = string
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "The instance type for the EC2 instance"
  type        = string
}

variable "key_name" {
  description = "The key name for SSH access to the EC2 instance"
  type        = string
}

variable "root_volume_size" {
  description = "The size of the root volume in GB"
  type        = number
  default     = 8
}

variable "ebs_volume_size" {
  description = "The size of the EBS volume in GB"
  type        = number
  default     = 20
}

variable "ebs_device_name" {
  description = "The device name for the EBS volume"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID where the EC2 instance will be deployed"
  type        = string
}

variable "subnet_ids" {
  description = "The subnet IDs for the EC2 instances"
  type        = list(string)
}

variable "zone_id" {
  description = "The Route 53 Hosted Zone ID"
  type        = string
}

variable "domain_name" {
  description = "The domain name for the Route 53 record"
  type        = string
}
