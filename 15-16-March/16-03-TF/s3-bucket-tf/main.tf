provider "aws" {
  region = "us-east-1"
}
resource "aws_s3_bucket" "versioned_bucket" {
  bucket        = "my-versioned-bucket-123"
  force_destroy = true # allows terraform to delete non-empty buckets

  tags = {
    Name        = "VersionedBucket"
    Environment = "Dev"
  }
}
resource "aws_s3_bucket_versioning" "versioning" {
    bucket =  aws_s3_bucket.versioned_bucket.id

    versioning_configuration {
      status = "Enabled"
    }
}

resource "aws_s3_bucket_policy" "public_read_policy" {
  bucket =  aws_s3_bucket.versioned_bucket.id
  policy = jsonencode({
    Version =  "2012-10-17"
    Statement = [
        {
            Sid = "PublicReadGetObject",
            Action = "s3:GetObject",
            Effect = "Allow",
            Resource = "${aws_s3_bucket.versioned_bucket.arn}/*",
            Principal = "*"
        }
    ]
  })
}