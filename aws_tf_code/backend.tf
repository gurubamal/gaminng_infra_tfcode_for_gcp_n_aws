terraform {
  backend "s3" {
    bucket         = var.tf_state_bucket
    key            = var.tf_state_key
    region         = var.aws_region
    encrypt        = true
    dynamodb_table = var.tf_state_lock_table
  }
}
