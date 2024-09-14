# Optional EC2 Instance for Additional Compute Needs
resource "aws_instance" "additional_compute" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.additional_instance_type
  subnet_id              = aws_subnet.public_subnets[0].id
  vpc_security_group_ids = [aws_security_group.eks_security_group.id]

  tags = {
    Name = "${var.environment}-additional-compute"
  }

  # Optional: User Data, IAM Role, etc.
}

# Data Source for Latest Amazon Linux AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Variable for Additional EC2 Instance Type
variable "additional_instance_type" {
  description = "Instance type for the additional EC2 instance."
  type        = string
  default     = "t3.large"
}
