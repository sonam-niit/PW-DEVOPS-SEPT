variable "ami_id" {}
variable "instance_type" {
  default = "t2.micro"
}
variable "key_name" {
  default = "sonam"
}
variable "user_data_path" {
  # default = "user_data.sh"
}
variable "subnet_ids" {
  type = list(string)
}
variable "target_group_arn" {  }
variable "sg_id" {}
variable "desired_capacity" {
  default = 2
}
variable "min_size" {
  default = 1
}
variable "max_size" {
  default = 3
}