# KMS Key for EKS Secrets Encryption
resource "aws_kms_key" "eks_key" {
  description = "KMS key for encrypting Kubernetes secrets"
  policy      = data.aws_iam_policy_document.eks_kms_policy.json
}

data "aws_iam_policy_document" "eks_kms_policy" {
  statement {
    actions = ["kms:*"]
    principals {
      type        = "Account"
      identifiers = [data.aws_caller_identity.current.account_id]
    }
    resources = ["*"]
  }
}

# Update EKS Cluster with Encryption Config
resource "aws_eks_cluster" "eks_cluster" {
  # Existing configuration

  encryption_config {
    provider {
      key_arn = aws_kms_key.eks_key.arn
    }
    resources = ["secrets"]
  }
}

data "aws_caller_identity" "current" {}
