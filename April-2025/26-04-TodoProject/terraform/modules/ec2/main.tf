resource "aws_instance" "this" {
    count         = var.instance_count
    ami           = var.ami_id
    instance_type = var.instance_type
    key_name      = var.key_name
    subnet_id     = element(var.subnet_ids, count.index)
    vpc_security_group_ids = [var.security_group_id]
    
    tags = {
        Name = "Backend-instance-${count.index + 1}"
    }
}