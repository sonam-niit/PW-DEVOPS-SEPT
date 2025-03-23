terraform {
    backend "s3" {
        bucket = "sonam-basket-84ddefd3"
        key = "terraform.tfstate"
        region = "us-east-1"
    }
}
