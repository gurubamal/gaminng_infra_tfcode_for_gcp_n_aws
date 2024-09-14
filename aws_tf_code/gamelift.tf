# IAM Role for GameLift
resource "aws_iam_role" "gamelift_role" {
  name = "${var.environment}-gamelift-role"

  assume_role_policy = data.aws_iam_policy_document.gamelift_assume_role_policy.json
}

data "aws_iam_policy_document" "gamelift_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["gamelift.amazonaws.com"]
    }
  }
}

# Attach GameLift Policies
resource "aws_iam_role_policy_attachment" "gamelift_AmazonGameLiftFullAccess" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonGameLiftFullAccess"
  role       = aws_iam_role.gamelift_role.name
}

# GameLift Fleet
resource "aws_gamelift_fleet" "gamelift_fleet" {
  name                 = "${var.environment}-gamelift-fleet"
  build_id             = aws_gamelift_build.game_build.id
  ec2_instance_type    = var.gamelift_instance_type
  fleet_type           = "ON_DEMAND"
  runtime_configuration {
    server_process {
      concurrent_executions = 1
      launch_path           = "/local/game/GameServer.exe"
    }
  }

  ec2_inbound_permissions {
    from_port = 7777
    to_port   = 7777
    ip_range  = "0.0.0.0/0"
    protocol  = "TCP"
  }

  tags = {
    Environment = var.environment
  }
}

# GameLift Build
resource "aws_gamelift_build" "game_build" {
  name        = "${var.environment}-game-build"
  operating_system = "WINDOWS_2016"
  storage_location {
    bucket  = var.game_build_bucket
    key     = var.game_build_key
    role_arn = aws_iam_role.gamelift_role.arn
  }
}
