provider "aws" {
  region = "us-east-1"
}
resource "aws_instance" "nginx_server" {
  ami = "ami-084568db4383264d4"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["sg-0a49e32881afdb9be"]
  key_name = "test-ansible"
  tags = {
    Name = "nginx-instance"
  }
  provisioner "local-exec" {
    command =<<EOT
cat <<EOF > ../ansible/inventory.yml
all:
  hosts:
    nginx-server:
      ansible_host: ${self.public_ip}
      ansible_user: ubuntu
      ansible_ssh_private_key_file: test-ansible.pem
EOF
EOT
  }
}
# resource "aws_security_group" "web_sg" {
#     name        = "web_sg"
#     description = "Allow HTTP and SSH"
#     ingress {
#         from_port   = 22
#         to_port     = 22
#         protocol    = "tcp"
#         cidr_blocks = ["0.0.0.0/0"]
#     }
#     ingress {
#         from_port   = 80
#         to_port     = 80
#         protocol    = "tcp"
#         cidr_blocks = ["0.0.0.0/0"]
#     }
#     egress {
#         from_port   = 0
#         to_port     = 0
#         protocol    = "-1"
#         cidr_blocks = ["0.0.0.0/0"]
#     }
# }