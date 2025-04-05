provider "aws" {
  region = "us-east-1"
}
resource "aws_s3_bucket" "website" {
  bucket = "cf-demo-basket"
  tags = {
    Name = "My cloudFront Bucket"
  }
}
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.website.id
  block_public_acls = false
  block_public_policy = false
  ignore_public_acls = false
  restrict_public_buckets = false
}
resource "aws_s3_bucket_policy" "policy_read" {
  bucket = aws_s3_bucket.website.id
  policy = jsonencode({
    "Version" = "2012-10-17",
    "Statement" = [
      {
        "Effect"    = "Allow",
        "Principal" = "*",
        "Action"    = "s3:GetObject",
        "Resource"  = "${aws_s3_bucket.website.arn}/*"
      }
    ]
  })
}
resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.website.id
  key = "index.html"
  source = "index.html"
  content_type = "text/html"
}
resource "aws_s3_object" "script" {
  bucket = aws_s3_bucket.website.id
  key = "script.js"
  source = "script.js"
  content_type = "text/script"
}
resource "aws_s3_object" "style" {
  bucket = aws_s3_bucket.website.id
  key = "style.css"
  source = "style.css"
  content_type = "text/css"
}

# output "static_url" {
#   value = aws_s3_bucket.website.website_domain
# }
