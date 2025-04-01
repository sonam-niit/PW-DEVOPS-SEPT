resource "aws_instance" "aws_instance" {
  ami = "ami-05c179eced2eb9b5b"
  instance_type = "t2.micro"
  # associate_public_ip_address = true
  subnet_id = aws_subnet.aws_subnet_public.id
  vpc_security_group_ids = [aws_security_group.aws_security_group.id]
  
  tags = {
    Name = "aws_instance"
  }
}

