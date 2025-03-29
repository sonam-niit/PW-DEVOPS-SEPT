env=$1

terraform workspace select $env || terraform workspace new $env
# try to select env and region file based on parameter
# and try to run let
terraform apply -auto-aprove