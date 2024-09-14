# SNS Topic for Alerts
resource "aws_sns_topic" "alerts_topic" {
  name = "${var.environment}-alerts-topic"
}

# Subscription (e.g., Email)
resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.alerts_topic.arn
  protocol  = "email"
  endpoint  = var.alerts_email
}

# Variable for Alerts Email
variable "alerts_email" {
  description = "Email address for receiving alerts."
  type        = string
}
