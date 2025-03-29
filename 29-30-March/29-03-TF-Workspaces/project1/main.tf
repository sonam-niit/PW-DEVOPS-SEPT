provider "aws" {
  region = var.region
}
resource "aws_s3_bucket" "sample" {
  bucket = var.bucket_name

  tags = {
    Name = "Terraform workspace"
    Environment = var.environment
  }
}
resource "aws_instance" "app_server" {
  ami = "ami-084568db4383264d4"
  instance_type = var.instance_type
  tags = {
    Name = "App Server"
    Environment = var.environment
  }
}