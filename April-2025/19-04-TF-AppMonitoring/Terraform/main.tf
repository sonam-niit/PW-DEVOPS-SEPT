provider "aws" {
  region = "us-east-1"
}

module "ec2" {
  source = "./ec2"
  instance_count = 2
}

module "elb" {
  source = "./elb"
  vpc_id = module.ec2.vpc_id
  instance_ids = module.ec2.instance_ids
  subnet_ids = module.ec2.subnet_ids
  target_group_ports = [80]
}