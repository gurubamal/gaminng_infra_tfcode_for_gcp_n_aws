# Hosted Zone (if not already existing)
resource "aws_route53_zone" "primary" {
  name = var.domain_name
}

# A Record for CloudFront
resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "www.${var.domain_name}"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.cdn.domain_name
    zone_id                = aws_cloudfront_distribution.cdn.hosted_zone_id
    evaluate_target_health = false
  }
}

# A Record for Global Accelerator
resource "aws_route53_record" "game" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "game.${var.domain_name}"
  type    = "A"

  alias {
    name                   = aws_globalaccelerator_accelerator.ga.dns_name
    zone_id                = aws_globalaccelerator_accelerator.ga.hosted_zone_id
    evaluate_target_health = false
  }
}

# Variable for Domain Name
variable "domain_name" {
  description = "Your domain name."
  type        = string
}
