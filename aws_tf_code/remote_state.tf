data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "my-network-tfstate-bucket"
    key    = "network/terraform.tfstate"
    region = var.aws_region
  }
}
