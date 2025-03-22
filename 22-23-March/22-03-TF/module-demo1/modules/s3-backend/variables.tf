variable "bucket_name" {
  description = "Name of S3 Bucket"
  type = string
}

variable "environment" {
  description = "Environment name (prod or dev)"
  type = st
}