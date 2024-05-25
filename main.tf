module "route53" {
  source       = "./route53"
  domain_name  = var.domain_name
  environment  = var.environment
}

data "aws_route53_zone" "selected" {
  name = var.domain_name
}

module "vpc" {
  source = "./vpc"
  aws_region = var.aws_region
}

module "ec2" {
  source          = "./ec2"
  aws_region      = var.aws_region
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.subnet_ids
  ami_id          = var.ami_id
  instance_type   = var.instance_type
  key_name        = var.key_name
  zone_id         = data.aws_route53_zone.selected.zone_id
  domain_name     = var.domain_name
  ebs_device_name = var.ebs_device_name
}