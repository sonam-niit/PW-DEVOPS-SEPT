output "bucket_name" {
  description = "The Bucket Name"
  value = aws_s3_bucket.sample.bucket
}
output "instance_id" {
  description = "ID for EC2 instance"
  value = aws_instance.app_server.id
}