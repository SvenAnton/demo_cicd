variable "ami_name" {
  default = "demo-payment-app"
}

variable "git_sha" {
  default = "none"
}

variable "github_run_id" {
  default = "0"
}

locals {
  environment = "ops-test-staging"
  region = "eu-central-1"
}
