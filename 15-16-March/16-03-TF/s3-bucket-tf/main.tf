provider "aws" {
  region = "us-east-1"
}
resource "aws_s3_bucket" "versioned_bucket" {
  bucket        = "my-versioned-bucket-123"
  force_destroy = true # allows terraform to delete non-empty buckets

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
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
resource "aws_s3_bucket_public_access_block" "bucket_block" {
  bucket = aws_s3_bucket.versioned_bucket.id
  block_public_policy = false
  block_public_acls = false
  ignore_public_acls = false
  restrict_public_buckets = false
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