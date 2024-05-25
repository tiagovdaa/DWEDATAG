variable "aws_region" {
  description = "The AWS region to create resources in"
  type        = string
  default     = "eu-west-1"
}

# route53 

variable "domain_name" {
  description = "The domain name for the Route 53 hosted zone"
  type        = string
  default     = "oldtechgeek.org"
}

variable "environment" {
  description = "The environment tag for the Route 53 hosted zone"
  type        = string
  default     = "production"
}

# ec2

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
  default     = "/dev/sdf"
}
