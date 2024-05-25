# ec2/outputs.tf

output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.web.id
}

output "public_ip" {
  description = "The public IP of the EC2 instance"
  value       = aws_instance.web.public_ip
}

output "availability_zone" {
  description = "The availability zone of the EC2 instance"
  value       = aws_instance.web.availability_zone
}

output "key_pair_name" {
  value = aws_key_pair.my_key_pair.key_name
}

output "volume_id" {
  value = aws_ebs_volume.web_data.id
}

output "ec2_instance_id" {
  value = aws_instance.web.id
}

output "ebs_device_name" {
  value = var.ebs_device_name
}