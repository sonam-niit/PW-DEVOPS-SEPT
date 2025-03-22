variable "instance_name" {
    type = string
    description = "Name tag for EC2 Instance"
}
variable "instance_type" {
    type = string
    description = "EC2 Instance Type"
}
variable "image_id" {
    type = string
    description = "AMI ID for EC2 Instance"
}