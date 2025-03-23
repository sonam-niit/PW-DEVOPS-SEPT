//File Provisioner
provider "aws" {
  region = "us-east-1"
}
resource "aws_instance" "web12" {
  ami           = "ami-084568db4383264d4"
  instance_type = "t2.micro"
  key_name      = "my_new_key"

  ## Upload file from local-to your instance
  provisioner "file" {
    source      = "scripts/setup.sh"
    destination = "/tmp/setup.sh"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("my_new_key.pem")
      host        = self.public_ip
    }
  }

  provisioner "remote-exec" {
    inline = [ 
        "chmod +x /tmp/setup.sh",
        "sudo /tmp/setup.sh"
     ]
     connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("my_new_key.pem")
      host        = self.public_ip
    }
  }

}
