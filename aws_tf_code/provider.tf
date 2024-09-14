# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
}

# Configure the Kubernetes Provider for EKS
provider "kubernetes" {
  host                   = aws_eks_cluster.eks_cluster.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.eks_cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster_auth.token
}

# Backend Configuration for Terraform State Management (e.g., using S3)
terraform {
  backend "s3" {
    bucket = var.tf_state_bucket
    key    = var.tf_state_key
    region = var.aws_region
  }
}
