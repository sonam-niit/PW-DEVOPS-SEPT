terraform {
  backend "s3" {
    bucket = "sonambasket12345"
    key = "global/s3/terraform.tfstate"
    region = "us-east-1"
  }
}