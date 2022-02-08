provider "aws" {
  region = local.region
}

terraform {
  backend "s3" {
    bucket = "demo-payment-app-terraform-states"
    key = "production/terraform.tfstate"
    region = "eu-central-1"
  }
}
