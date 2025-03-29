variable "region" {
  description = "AWS region"
  # default = "us-east-1"
}
variable "instance_type" {
  description = "EC2 Instance type"
  default = "t2.micro"
}
variable "environment" {
  description = "Environment Name"
}
variable "bucket_name" {
  description = "S3 Bucket name"
}