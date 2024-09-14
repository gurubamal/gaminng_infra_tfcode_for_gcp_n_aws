# Get Availability Zones
data "aws_availability_zones" "available" {
  state = "available"
}

# Get AWS Caller Identity
data "aws_caller_identity" "current" {}

# Get Latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}
