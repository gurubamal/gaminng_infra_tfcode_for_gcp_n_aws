# Global Accelerator
resource "aws_globalaccelerator_accelerator" "ga" {
  name               = "${var.environment}-accelerator"
  enabled            = true
  ip_address_type    = "IPV4"

  attributes = {
    flow_logs_enabled = false
  }
}

# Listener
resource "aws_globalaccelerator_listener" "ga_listener" {
  accelerator_arn = aws_globalaccelerator_accelerator.ga.id
  protocol        = "TCP"
  port_range {
    from_port = 7777
    to_port   = 7777
  }
}

# Endpoint Group
resource "aws_globalaccelerator_endpoint_group" "ga_endpoint_group" {
  listener_arn = aws_globalaccelerator_listener.ga_listener.id
  endpoint_configuration {
    endpoint_id = aws_gamelift_fleet.gamelift_fleet.id
    weight      = 100
  }
}
