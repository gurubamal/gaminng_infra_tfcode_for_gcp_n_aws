# AWS WAFv2 Web ACL
resource "aws_wafv2_web_acl" "waf" {
  name        = "${var.environment}-web-acl"
  scope       = "CLOUDFRONT"
  default_action {
    allow {}
  }

  rule {
    name     = "AWS-AWSManagedRulesCommonRuleSet"
    priority = 1
    override_action {
      none {}
    }
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"
      }
    }
    visibility_config {
      sampled_requests_enabled = true
      cloudwatch_metrics_enabled = true
      metric_name = "awsCommonRules"
    }
  }

  visibility_config {
    sampled_requests_enabled = true
    cloudwatch_metrics_enabled = true
    metric_name = "webACL"
  }
}

# Associate WAF with CloudFront
resource "aws_cloudfront_distribution" "cdn" {
  # Existing CloudFront configuration

  web_acl_id = aws_wafv2_web_acl.waf.arn
}
