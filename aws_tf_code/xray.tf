# Enable X-Ray on API Gateway
resource "aws_api_gateway_stage" "api_stage" {
  stage_name    = "prod"
  rest_api_id   = aws_api_gateway_rest_api.api.id
  deployment_id = aws_api_gateway_deployment.api_deployment.id

  xray_tracing_enabled = true
}

# IAM Role for X-Ray Daemon (if running on EC2 or ECS)
resource "aws_iam_role" "xray_role" {
  name = "${var.environment}-xray-role"

  assume_role_policy = data.aws_iam_policy_document.xray_assume_role_policy.json
}

data "aws_iam_policy_document" "xray_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["xray.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "xray_role_policy" {
  role       = aws_iam_role.xray_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSXRayDaemonWriteAccess"
}
