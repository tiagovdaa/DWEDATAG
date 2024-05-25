resource "aws_ebs_volume" "web_data" {
  availability_zone = aws_instance.web.availability_zone
  size              = var.ebs_volume_size
  tags = {
    Name = "web-data-volume"
  }
}

resource "aws_volume_attachment" "web_data_attachment" {
  device_name = var.ebs_device_name
  volume_id   = aws_ebs_volume.web_data.id
  instance_id = aws_instance.web.id
  force_detach = true
}
