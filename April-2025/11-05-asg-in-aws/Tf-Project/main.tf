provider "aws" {
  region = "us-east-1"
}

module "networking" {
  source = "./modules/networking"
  azs = [ "us-east-1a", "us-east-1b" ]
}

module "asg" {
    source = "./modules/asg"
    key_name = "sonam"
    ami_id = "ami-0f88e80871fd81e91" # Amazon Linux 2 AMI
    subnet_ids = module.networking.subnet_ids
    sg_id = module.networking.security_group_id
    target_group_arn = module.alb.target_group_arn
    user_data_path = "${path.module}/user_data.sh"
}

module "alb" {
    source = "./modules/alb"
    subnet_ids = module.networking.subnet_ids
    security_group_id = module.networking.security_group_id
    vpc_id = module.networking.vpc_id
  
}
