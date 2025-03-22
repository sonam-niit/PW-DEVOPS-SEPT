## Considering this as Child Module

resource "aws_instance" "web" {
  ami = var.image_id
  instance_type = var.instance_type

  tags = {
    Name = var.instance_name
  }
}