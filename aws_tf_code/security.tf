# AWS WAF Web ACL
resource "aws_waf_web_acl" "web_acl" {
  name        = "${var.environment}-web-acl"
  metric_name = "${var.environment}WebACL"

  default_action {
    type = "ALLOW"
  }

  # Define rules as needed
}

# Associate WAF with CloudFront
resource "aws_cloudfront_distribution" "cdn" {
  # Existing CloudFront configuration

  web_acl_id = aws_waf_web_acl.web_acl.id
}

# AWS Shield Advanced Protection (Note: Requires Enterprise Support Plan)
resource "aws_shield_protection" "shield_protection" {
  name         = "${var.environment}-shield-protection"
  resource_arn = aws_cloudfront_distribution.cdn.arn
}
