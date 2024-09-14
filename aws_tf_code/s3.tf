# S3 Bucket for Static Content
resource "aws_s3_bucket" "static_content" {
  bucket = "${var.environment}-static-content"
  acl    = "public-read"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  tags = {
    Environment = var.environment
  }
}

# S3 Bucket for GameLift Builds
resource "aws_s3_bucket" "gamelift_builds" {
  bucket = "${var.environment}-gamelift-builds"
  acl    = "private"

  tags = {
    Environment = var.environment
  }
}

# Variable for Game Build Bucket
variable "game_build_bucket" {
  description = "S3 bucket for GameLift builds."
  type        = string
  default     = aws_s3_bucket.gamelift_builds.bucket
}

# Variable for Game Build Key
variable "game_build_key" {
  description = "S3 key for the GameLift build zip file."
  type        = string
}
