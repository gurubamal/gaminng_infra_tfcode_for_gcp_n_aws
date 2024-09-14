variable "aws_region" {
  description = "The AWS region to deploy resources in."
  type        = string
  default     = "us-west-2"
}

variable "environment" {
  description = "Deployment environment (e.g., dev, staging, prod)."
  type        = string
  default     = "dev"
}

variable "eks_cluster_name" {
  description = "Name of the EKS cluster."
  type        = string
  default     = "game-platform-eks"
}

variable "node_instance_type" {
  description = "EC2 instance type for EKS worker nodes."
  type        = string
  default     = "t3.medium"
}

variable "desired_node_count" {
  description = "Desired number of worker nodes in the EKS cluster."
  type        = number
  default     = 3
}

variable "tf_state_bucket" {
  description = "S3 bucket name for Terraform state."
  type        = string
}

variable "tf_state_key" {
  description = "S3 key for Terraform state file."
  type        = string
}
