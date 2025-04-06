provider "aws" {
  region = var.region
}
resource "aws_s3_bucket" "static_site" {
  bucket = var.bucket_name
  force_destroy = true
}
resource "aws_s3_bucket_website_configuration" "site_config" {
  bucket = aws_s3_bucket.static_site.bucket
  index_document {
    suffix = "index.html"
  }
#   error_document {
#     key = "error.html"
#   }
}
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket                  = aws_s3_bucket.static_site.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
resource "aws_s3_bucket_policy" "policy_read" {
  bucket = aws_s3_bucket.static_site.id
  policy = jsonencode({
    "Version" = "2012-10-17",
    "Statement" = [
      {
        "Sid"       = "AllowCloudFrontServicePrincipalReadOnly"
        "Effect"    = "Allow",
        "Principal" = {
            Service = "cloudfront.amazonaws.com"
        }
        "Action"    = "s3:GetObject",
        "Resource"  = "${aws_s3_bucket.static_site.arn}/*"
        "Condition" = {
            StringEquals = {
                "AWS:SourceArn" = aws_cloudfront_distribution.s3_distribution.arn
            }
        }
      }
    ]
  })
}
# upload all files in bucket
resource "aws_s3_object" "site_files" {
  for_each = fileset("${path.module}/static-site", "*")
  bucket   = aws_s3_bucket.static_site.bucket
  key      = each.value
  source   = "${path.module}/static-site/${each.value}"
  content_type = lookup(
    {
      html = "text/html"
      css  = "text/css"
      js   = "application/javascript"
    }, split(".", each.value)[1], "text/plain"
  )
}

## cloudfront Configuration
## CF Origin Access Control (OCA)
resource "aws_cloudfront_origin_access_control" "oac" {
  name                              = "s3-oac-${var.bucket_name}"
  description                       = "Access S3 only from Cloud Front"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name              = aws_s3_bucket.static_site.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
    origin_id                = "s3-origin-${var.bucket_name}"
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Deployment of Static Site"
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "s3-origin-${var.bucket_name}"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "https-only"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
