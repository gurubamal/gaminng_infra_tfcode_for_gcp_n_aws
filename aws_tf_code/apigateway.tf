# API Gateway Rest API
resource "aws_api_gateway_rest_api" "api" {
  name        = "${var.environment}-api"
  description = "API Gateway for game platform"
}

# Resource (e.g., /players)
resource "aws_api_gateway_resource" "players_resource" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "players"
}

# Method (e.g., GET /players)
resource "aws_api_gateway_method" "get_players" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.players_resource.id
  http_method   = "GET"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.cognito_authorizer.id
}

# Integrate with AWS Lambda or EKS Services (assuming EKS)
resource "aws_api_gateway_integration" "get_players_integration" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.players_resource.id
  http_method = aws_api_gateway_method.get_players.http_method
  type        = "HTTP_PROXY"
  uri         = "http://${module.eks_cluster.endpoint}/players"
}

# Deploy API
resource "aws_api_gateway_deployment" "api_deployment" {
  depends_on = [aws_api_gateway_integration.get_players_integration]
  rest_api_id = aws_api_gateway_rest_api.api.id
  stage_name  = "prod"
}

# Cognito Authorizer
resource "aws_api_gateway_authorizer" "cognito_authorizer" {
  name               = "${var.environment}-cognito-authorizer"
  rest_api_id        = aws_api_gateway_rest_api.api.id
  type               = "COGNITO_USER_POOLS"
  identity_source    = "method.request.header.Authorization"
  provider_arns      = [aws_cognito_user_pool.user_pool.arn]
}
