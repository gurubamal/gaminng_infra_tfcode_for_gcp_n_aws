resource "google_compute_security_policy" "cloud_armor_policy" {
  name        = "gaming-cloud-armor-policy"
  description = "Cloud Armor policy for the gaming platform"

  rule {
    action = "allow"
    priority = 1000
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = ["0.0.0.0/0"]
      }
    }
  }
}

resource "google_compute_backend_service" "secured_backend" {
  name        = "secured-backend-service"
  protocol    = "TCP"
  port_name   = "http"
  timeout_sec = 10

  backend {
    group = google_container_cluster.primary.instance_group_urls[0]
  }

  health_checks         = [google_compute_health_check.default.self_link]
  security_policy       = google_compute_security_policy.cloud_armor_policy.id
  connection_draining {
    draining_timeout_sec = 300
  }
}
