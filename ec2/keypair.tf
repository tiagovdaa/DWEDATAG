resource "aws_key_pair" "my_key_pair" {
  key_name   = "otg"
  public_key = file("~/.ssh/id_rsa.pub")
}