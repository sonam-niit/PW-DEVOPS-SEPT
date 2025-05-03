cd terraform/environments/dev

terraform init

terraform apply -auto-approve

terraform output -raw ansible_inventory_file > ../../../ansible/inventory.yml

cd ../../../ansible

ansible-playbook -i inventory.yml playbook.yml

