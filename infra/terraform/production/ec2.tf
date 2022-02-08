resource "aws_key_pair" "ubuntu-prod" {
  key_name   = "ubuntu-prod"
  public_key = file("keys/terraform-tutorial.pub")
  tags = {
    Name        = "demo-payment-app-ssh-key-prod"
    Environment = local.environment
  }
}

data "aws_ami" "deploy_image" {
  owners      = ["self"]
  most_recent = true
  filter {
    name   = "name"
    values = ["demo-payment-app-*"]
  }
  filter {
    name   = "tag:COMMIT_SHA"
    values = ["${var.git_sha}"]
  }
}

resource "aws_instance" "test-ec2-instance" {
  ami                    = data.aws_ami.deploy_image.id
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.ubuntu-prod.key_name
  vpc_security_group_ids = ["${aws_security_group.ingress-all-test.id}"]
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("terraform-tutorial")
    host        = self.public_ip
  }
  tags = {
    Environment = local.environment
    Name        = "production-demo-payment-app"
    GITHUB_SHA  = "${var.git_sha}"
    GITHUB_RUN_ID = "${var.github_run_id}"
  }
  subnet_id = aws_subnet.subnet-uno.id
}
