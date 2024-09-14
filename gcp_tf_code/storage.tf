resource "google_storage_bucket" "game_assets" {
  name     = "${var.project_id}-game-assets"
  location = var.region
  force_destroy = true

  uniform_bucket_level_access = true

  lifecycle_rule {
    action {
      type = "SetStorageClass"
      storage_class = "NEARLINE"
    }
    condition {
      age = 30
    }
  }

  versioning {
    enabled = true
  }
}
