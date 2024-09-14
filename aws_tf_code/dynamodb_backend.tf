# DynamoDB Table for State Locking
resource "aws_dynamodb_table" "tf_state_lock" {
  name           = var.tf_state_lock_table
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}
