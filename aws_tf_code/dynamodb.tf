# DynamoDB Table for Player Data
resource "aws_dynamodb_table" "player_data" {
  name           = "${var.environment}-player-data"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "PlayerID"

  attribute {
    name = "PlayerID"
    type = "S"
  }

  tags = {
    Environment = var.environment
  }
}
