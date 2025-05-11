output "vpc_id" {
  description = "The VPC ID"
  value       = aws_vpc.this.id
}
output "subnet_ids" {
  description = "List of subnet IDs"
  value       = aws_subnet.this[*].id
}
output "security_group_id" {
  description = "Security group ID"
  value       = aws_security_group.this.id
}