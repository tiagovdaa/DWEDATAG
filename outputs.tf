output "vpc_id" {
  value = module.vpc.vpc_id
}
output "subnet_ids" {
  value = module.vpc.subnet_ids
}

output "igw_id" {
  value = module.vpc.igw_id
}

output "ec2_public_ip" {
  value = module.ec2.public_ip
}

output "volume_id" {
  value = module.ec2.volume_id
}

output "ec2_instance_id" {
  value = module.ec2.ec2_instance_id
}

output "ebs_device_name" {
  value = module.ec2.ebs_device_name
}