resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "${var.environment}-eks-node-group"
  node_role_arn   = aws_iam_role.eks_node_group_role.arn
  subnet_ids      = aws_subnet.public_subnets[*].id

  scaling_config {
    desired_size = var.desired_node_count
    max_size     = var.desired_node_count + 2
    min_size     = 1
  }

  instance_types = [var.node_instance_type]

  tags = {
    Name = "${var.environment}-eks-node-group"
  }
}
