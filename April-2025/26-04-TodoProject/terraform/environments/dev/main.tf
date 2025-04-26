provider "aws" {
  region = "us-east-1"
}

module "networking" {
  source = "../../modules/networking"
    azs = [ "us-east-1a", "us-east-1b" ]
}

module "ec2" {
    source = "../../modules/ec2"
    instance_count = 2
    key_name = "todo-app"
    ami_id = "ami-084568db4383264d4" # Ubuntu 20.04 LTS
    subnet_ids = module.networking.subnet_ids
    security_group_id = module.networking.security_group_id
}

module "alb" {
    source = "../../modules/alb"
    subnet_ids = module.networking.subnet_ids
    security_group_id = module.networking.security_group_id
    vpc_id = module.networking.vpc_id
    instance_ids = module.ec2.instance_ids
  
}