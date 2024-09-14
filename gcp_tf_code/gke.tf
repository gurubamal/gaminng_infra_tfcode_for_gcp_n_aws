resource "google_container_cluster" "primary" {
  name               = var.gke_cluster_name
  location           = var.region
  initial_node_count = 1
  remove_default_node_pool = true
  network            = google_compute_network.vpc_network.name
  subnetwork         = google_compute_subnetwork.subnet.name
  ip_allocation_policy {
    use_ip_aliases = true
  }

  master_auth {
    username = ""
    password = ""
    client_certificate_config {
      issue_client_certificate = false
    }
  }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  identity_service_config {
    enabled = true
  }

  enable_shielded_nodes = true
}

resource "google_container_node_pool" "primary_nodes" {
  name       = var.node_pool_name
  location   = var.region
  cluster    = google_container_cluster.primary.name
  node_count = var.node_count

  node_config {
    machine_type = var.machine_type
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
    service_account = google_service_account.gke_service_account.email
    labels = {
      env = "prod"
    }
    metadata = {
      disable-legacy-endpoints = "true"
    }
    tags = ["gke-node"]
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  autoscaling {
    min_node_count = 1
    max_node_count = 5
  }
}
