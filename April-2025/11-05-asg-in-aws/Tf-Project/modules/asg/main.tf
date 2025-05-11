resource "aws_launch_template" "lt" {
    name_prefix   = "web-lt-"
    image_id      = var.ami_id
    instance_type = var.instance_type
    key_name      = var.key_name
    user_data     = base64encode(file(var.user_data_path))
    
    network_interfaces {
        associate_public_ip_address = true
        security_groups = [var.sg_id]
    }
}
resource "aws_autoscaling_group" "asg" {
    desired_capacity     = var.desired_capacity
    min_size             = var.min_size
    max_size             = var.max_size
    vpc_zone_identifier = var.subnet_ids
    target_group_arns = [var.target_group_arn]
    health_check_type = "ELB"
    health_check_grace_period = 60
    launch_template {
        id      = aws_launch_template.lt.id
        version = "$Latest"
    }
    tag {
        key                 = "Name"
        value               = "web-asg-instance"
        propagate_at_launch = true
    }
}