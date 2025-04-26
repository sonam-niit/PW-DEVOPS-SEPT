output "alb_dns" {
    description = "The DNS name of the ALB"
    value       = module.alb.alb_dns_name
}
output "ansible_inventory" {
    description = "Ansible inventory for the EC2 instances"
    value       = join("\n", [
        for instance in module.ec2.instance_ips : "${instance} ansible_ssh_private_key_file=todo-app ansible_user=ubuntu"
    ])
  
}
output "ansible_inventory_file" {
    description = "Path to the Ansible inventory file"
    value       = yamlencode({
        all = {
            hosts = {
                for idx, ip in module.ec2.instance_ips : "backend${idx+1}" => {
                    ansible_hostname             = ip
                    ansible_ssh_private_key_file = "todo-app.pem"
                    ansible_user                 = "ubuntu"
                }
            }
        }
        children = {
            backend = {
                hosts = {
                    for idx, ip in module.ec2.instance_ips : "backend${idx+1}" => {}
                }
            }
        }
    })
  
}