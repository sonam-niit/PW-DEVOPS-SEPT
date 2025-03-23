## Init and apply
terraform init
terraform apply -auto-approve

# Save Output
BUCKEt_NAME=$(terraform output -raw bucket_name)

## Create backend.tf dynamically
cat > backend.tf <<EOF
terraform {
    backend "s3" {
        bucket = "$BUCKEt_NAME"
        key = "terraform.tfstate"
        region = "us-east-1"
    }
}
EOF

## Apply
terraform init -auto-approve
terraform apply -auto-approve