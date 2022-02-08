packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.1"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

variable "ami_prefix" {
  type    = string
  default = "demo-payment-app"
}

variable "my_custom_var" {
  type    = string
  default = "default_custom_var"
}

variable "commit_sha" {
  type    = string
  default = "none"
}

locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}

source "amazon-ebs" "ubuntu" {
  ami_name                    = "${var.ami_prefix}-${local.timestamp}"
  instance_type               = "t2.micro"
  region                      = "eu-central-1"
  source_ami                  = "ami-05f7491af5eef733a"
  ssh_username                = "ubuntu"
  associate_public_ip_address = true
  subnet_filter {
    filters = {
      "tag:Environment" : "ops-test-staging"
    }
  }

  security_group_filter {
    filters = {
      "tag:Environment" : "ops-test-staging"
    }
  }

  tags = {
    COMMIT_SHA  = "${var.commit_sha}"
    Environment = "ops-test"
  }
}

build {
  name = "demo-payment-app"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]

  provisioner "ansible" {
    playbook_file = "./playbooks/main.yml"
  }
}
