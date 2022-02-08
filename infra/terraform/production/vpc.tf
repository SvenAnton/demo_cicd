resource "aws_vpc" "test-env" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name        = "demo-payment-app-vpc-prod"
    Environment = local.environment
  }
}
resource "aws_eip" "ip-test-env" {
  instance = aws_instance.test-ec2-instance.id
  vpc      = true
  tags = {
    Name        = "demo-payment-app-eip-prod"
    Environment = local.environment
  }
}

resource "aws_subnet" "subnet-uno" {
  cidr_block        = cidrsubnet(aws_vpc.test-env.cidr_block, 3, 1)
  vpc_id            = aws_vpc.test-env.id
  availability_zone = "${local.region}a"
  tags = {
    Name        = "demo-payment-app-subnet-uno-prod"
    Environment = local.environment
  }
}
resource "aws_route_table" "route-table-test-env" {
  vpc_id = aws_vpc.test-env.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.test-env-gw.id
  }
  tags = {
    Name        = "demo-payment-app-route-table-prod"
    Environment = local.environment
  }
}
resource "aws_route_table_association" "subnet-association" {
  subnet_id      = aws_subnet.subnet-uno.id
  route_table_id = aws_route_table.route-table-test-env.id
}

resource "aws_internet_gateway" "test-env-gw" {
  vpc_id = aws_vpc.test-env.id
  tags = {
    Name        = "demo-payment-app-internet-gw-prod"
    Environment = local.environment
  }
}
