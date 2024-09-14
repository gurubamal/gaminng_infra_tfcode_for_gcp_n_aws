resource "google_monitoring_notification_channel" "email_notifications" {
  display_name = "Email Notifications"
  type         = "email"

  labels = {
    email_address = "ops-team@gaming-company.com"
  }
}

resource "google_monitoring_alert_policy" "high_cpu_usage" {
  display_name = "High CPU Usage Alert"

  combiner = "OR"

  conditions {
    display_name = "VM Instance CPU Usage"
    condition_threshold {
      filter = "metric.type=\"compute.googleapis.com/instance/cpu/utilization\" resource.type=\"gce_instance\""
      duration = "60s"
      comparison = "COMPARISON_GT"
      threshold_value = 0.8
      trigger {
        count = 1
      }
    }
  }

  notification_channels = [google_monitoring_notification_channel.email_notifications.name]
}
