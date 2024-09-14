# AWS Shield Advanced Protection
resource "aws_shield_protection" "shield_protection" {
  name         = "${var.environment}-shield-protection"
  resource_arn = aws_cloudfront_distribution.cdn.arn
}
