resource "aws_instance" "web" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = element(var.subnet_ids, 0)  
  user_data              = file("${path.module}/userdata.sh")
  vpc_security_group_ids = [aws_security_group.web_sg.id] 

  tags = {
    Name = "web-instance"
  }

  root_block_device {
    volume_size = var.root_volume_size
  }
}
