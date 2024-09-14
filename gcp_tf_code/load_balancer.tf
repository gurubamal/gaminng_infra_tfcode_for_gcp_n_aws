resource "google_compute_global_address" "lb_ip" {
  name = "gaming-platform-lb-ip"
}

resource "google_compute_backend_service" "default" {
  name        = "gaming-backend-service"
  protocol    = "TCP"
  port_name   = "http"
  timeout_sec = 10

  backend {
    group = google_container_cluster.primary.instance_group_urls[0]
  }

  health_checks = [google_compute_health_check.default.self_link]
}

resource "google_compute_health_check" "default" {
  name = "gaming-health-check"

  tcp_health_check {
    port = 80
  }
}

resource "google_compute_url_map" "default" {
  name            = "gaming-url-map"
  default_service = google_compute_backend_service.default.self_link
}

resource "google_compute_target_http_proxy" "default" {
  name   = "gaming-http-proxy"
  url_map = google_compute_url_map.default.self_link
}

resource "google_compute_global_forwarding_rule" "default" {
  name       = "gaming-forwarding-rule"
  ip_address = google_compute_global_address.lb_ip.address
  port_range = "80"
  target     = google_compute_target_http_proxy.default.self_link
}
