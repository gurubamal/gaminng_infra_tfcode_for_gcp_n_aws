# ElastiCache Subnet Group
resource "aws_elasticache_subnet_group" "cache_subnet_group" {
  name       = "${var.environment}-cache-subnet-group"
  subnet_ids = aws_subnet.public_subnets[*].id
}

# ElastiCache Cluster
resource "aws_elasticache_cluster" "redis_cluster" {
  cluster_id           = "${var.environment}-redis-cluster"
  engine               = "redis"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis3.2"
  port                 = 6379
  subnet_group_name    = aws_elasticache_subnet_group.cache_subnet_group.name
  security_group_ids   = [aws_security_group.eks_security_group.id]

  tags = {
    Environment = var.environment
  }
}
