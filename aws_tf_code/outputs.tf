# Output the EKS Cluster Name
output "eks_cluster_name" {
  description = "The name of the EKS cluster"
  value       = aws_eks_cluster.eks_cluster.name
}

# Output the EKS Cluster Endpoint
output "eks_cluster_endpoint" {
  description = "The endpoint of the EKS cluster"
  value       = aws_eks_cluster.eks_cluster.endpoint
}

# Output the EKS Cluster Certificate
output "eks_cluster_certificate_authority" {
  description = "Base64 encoded certificate data required to communicate with the cluster"
  value       = aws_eks_cluster.eks_cluster.certificate_authority[0].data
}

# Output the Load Balancer DNS Name (e.g., for the Ingress Controller)
output "ingress_controller_lb_dns" {
  description = "DNS name of the Ingress Controller's Load Balancer"
  value       = kubernetes_service.nginx_ingress_service.status[0].load_balancer[0].ingress[0].hostname
}
