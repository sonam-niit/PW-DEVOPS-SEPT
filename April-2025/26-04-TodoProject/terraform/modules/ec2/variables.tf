variable "instance_count" {
    description = "Number of EC2 instances to create"
    type        = number
    default     = 2
}
variable "ami_id" {
    description = "AMI ID for the EC2 instance"
    type        = string
}
variable "instance_type" {
    description = "Type of EC2 instance"
    type        = string
    default     = "t2.micro"
  
}
variable "key_name" {
    description = "Name of the key pair to use for SSH access"
    type        = string
    default     = "my-key-pair" 
}
variable "subnet_ids" {
    description = "List of subnet IDs to launch the instances in"
    type        = list(string)
}
variable "security_group_id" {
    description = "Security group ID to associate with the instances"
    type        = string
}