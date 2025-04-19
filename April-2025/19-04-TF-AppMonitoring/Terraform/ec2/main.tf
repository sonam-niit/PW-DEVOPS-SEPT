resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}
resource "aws_subnet" "subnet" {
  count = 2
  cidr_block = cidrsubnet("10.0.0.0/16",4,count.index)
  vpc_id = aws_vpc.main.id
  availability_zone = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
}
resource "aws_route_table_association" "public_assoc" {
  count =  length((aws_subnet.subnet))
  subnet_id = aws_subnet.subnet[count.index].id 
  route_table_id = aws_route_table.public_rt.id
}

data "aws_availability_zones" "available" {}
resource "aws_security_group" "ec2_sg" {
  name = "ec2_sg"
  description = "Allow HTTP and SSH"
  vpc_id = aws_vpc.main.id
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 22
    to_port = 22
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
resource "aws_instance" "web" {
  count = var.instance_count
  ami = "ami-0e449927258d45bc4"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.subnet[count.index].id
  vpc_security_group_ids = [ aws_security_group.ec2_sg.id ]
  user_data = <<-EOF
  #!/bin/bash
  echo "Hello from Server ${count.index+1}" > /var/www/html/index.html
  yum install -u httpd
  systemctl start httpd
  systemctl enable httpd
  mv /var/www/html/index.html /var/www/html/index.html
  EOF
  tags = {
    Name = "web-server-${count.index+1}"
  }
}