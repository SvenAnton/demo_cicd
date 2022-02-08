variable "git_sha" {
  default = "none"
}

variable "github_run_id" {
  default = "0"
}

locals {
  environment = "ops-test-prod"
  region = "eu-central-1"
  project = "demo-payment-app"
}
