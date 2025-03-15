# provider "local" {}

# resource "local_file" "sample" {
#   filename = "hello.txt"
#   content  = "Hello, From Terraform!!"
# }

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "server1" {
  ami = "ami-08b5b3a93ed654d19"
  instance_type =  "t2.micro"

  tags = {
    Name: "SonamVM"
  }
}