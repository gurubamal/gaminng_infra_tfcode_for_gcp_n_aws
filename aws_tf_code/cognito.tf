# Cognito User Pool
resource "aws_cognito_user_pool" "user_pool" {
  name = "${var.environment}-user-pool"

  auto_verified_attributes = ["email"]

  tags = {
    Environment = var.environment
  }
}

# Cognito App Client
resource "aws_cognito_user_pool_client" "app_client" {
  name         = "${var.environment}-app-client"
  user_pool_id = aws_cognito_user_pool.user_pool.id
  generate_secret = false
}

# Cognito Identity Pool
resource "aws_cognito_identity_pool" "identity_pool" {
  identity_pool_name = "${var.environment}-identity-pool"
  allow_unauthenticated_identities = false

  cognito_identity_providers {
    client_id = aws_cognito_user_pool_client.app_client.id
    provider_name = aws_cognito_user_pool.user_pool.endpoint
  }
}

# IAM Roles for Cognito
resource "aws_iam_role" "authenticated_role" {
  name = "${var.environment}-cognito-authenticated-role"

  assume_role_policy = data.aws_iam_policy_document.authenticated_assume_role_policy.json
}

data "aws_iam_policy_document" "authenticated_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

    condition {
      test     = "StringEquals"
      variable = "${aws_cognito_identity_pool.identity_pool.id}:aud"
      values   = [aws_cognito_identity_pool.identity_pool.id]
    }

    principals {
      type        = "Federated"
      identifiers = ["cognito-identity.amazonaws.com"]
    }
  }
}
