variable "bucket_name" {
    description = "The name of the S3 bucket to be used as the origin for the CloudFront distribution."
    type        = string
}
variable "s3_bucket_domain_name" {
  description = "The domain name of the S3 bucket to be used as the origin for the CloudFront distribution."
  type        = string
}
variable "comment" {
  description = "Comment for the CloudFront distribution."
  type        = string
  default     = "CloudFront Distribution"
}
variable "default_root_object" {
  description = "The default root object for the CloudFront distribution."
  type        = string
  default     = "index.html"
}