provider "aws" {
  region = "us-east-1"
}

module "web_server" {
  source = "./modules/ec2-module"
  instance_name = "My_Instance"
  instance_type="t2.micro"
  image_id="ami-084568db4383264d4"
}

module "s3_bucket" {
  source = "./modules/s3-backend"
  prefix = "sonambasket"
  environment = "dev"
}