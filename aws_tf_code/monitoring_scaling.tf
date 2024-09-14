# CloudWatch Metrics for EKS Cluster
resource "aws_cloudwatch_metric_alarm" "high_cpu_alarm" {
  alarm_name          = "${var.environment}-high-cpu-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EKS"
  period              = "120"
  statistic           = "Average"
  threshold           = "80"

  dimensions = {
    ClusterName = aws_eks_cluster.eks_cluster.name
  }

  alarm_actions = [aws_autoscaling_policy.scale_out_policy.arn]
}

# Auto Scaling Policy
resource "aws_autoscaling_policy" "scale_out_policy" {
  name                   = "${var.environment}-scale-out"
  autoscaling_group_name = aws_eks_node_group.eks_node_group.resources[0].autoscaling_groups[0]
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
}

# AWS X-Ray (Assuming it's enabled in your application)
# No specific Terraform resources are needed unless additional configurations are required.

# SNS Topic for Notifications
resource "aws_sns_topic" "alerts_topic" {
  name = "${var.environment}-alerts-topic"
}

# CloudWatch Alarm Notifications
resource "aws_cloudwatch_metric_alarm" "alarm_notification" {
  # Reuse the high_cpu_alarm or define new alarms
  depends_on = [aws_cloudwatch_metric_alarm.high_cpu_alarm]

  alarm_actions = [aws_sns_topic.alerts_topic.arn]
}
