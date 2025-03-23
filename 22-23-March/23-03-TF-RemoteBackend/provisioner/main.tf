# Local Provisioner
# resource "null_resource" "local_example" {
#   provisioner "local-exec" {
#     command = "echo 'example of Local Provisioner'"
#   }
# }

## Remote Provisioner

provider "aws" {
  region = "us-east-1"
}

resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "aws_key_pair" "key" {
  key_name = "my_new_key"
  public_key = tls_private_key.ssh_key.public_key_openssh
}
#Save Private Key
 resource "local_file" "private_key" {
   content = tls_private_key.ssh_key.private_key_pem
   filename = "my_new_key.pem"
   file_permission = "0600"
   directory_permission = "0700"
 }
resource "aws_instance" "webapp" {
  ami = "ami-084568db4383264d4"
  instance_type = "t2.micro"
  key_name = "my_new_key"
  vpc_security_group_ids = [aws_security_group.web_sg.id] 

  provisioner "remote-exec" {
    inline = [ 
        "sudo apt-get update",
        "sudo apt-get install -y nginx",
        "sudo systemctl start nginx"
     ]
     connection {
       type = "ssh"
       user = "ubuntu"
       private_key = file("my_new_key.pem")
       host = self.public_ip
     }
  }

  tags = {
    Name = "Provisioner Instance"
  }
  depends_on = [ aws_key_pair.key ]
  #first generate key then create aws instance
}

resource "aws_security_group" "web_sg" {
    name        = "web_sg"
    description = "Allow HTTP and SSH"
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
