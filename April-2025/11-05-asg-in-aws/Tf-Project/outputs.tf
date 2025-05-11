output "alb_dns" {
  description = "The DNS name of the ALB"
  value       = module.alb.alb_dns_name
}
output "asg_name" {
  description = "The name of the ASG"
  value       = module.asg.asg_name
}