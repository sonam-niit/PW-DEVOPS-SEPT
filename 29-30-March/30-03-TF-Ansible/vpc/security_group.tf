# CREATE SECURITY GROUP

resource "aws_security_group" "aws_security_group" {
  vpc_id = aws_vpc.aws_vpc.id
  # tags = {
  #   Name = "aws_security_group"
  # }
  name = "aws_security_group"

  ingress{
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}