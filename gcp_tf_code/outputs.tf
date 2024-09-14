output "gke_cluster_name" {
  description = "Name of the GKE Cluster"
  value       = google_container_cluster.primary.name
}

output "gke_cluster_endpoint" {
  description = "Endpoint of the GKE Cluster"
  value       = google_container_cluster.primary.endpoint
}

output "gke_cluster_ca_certificate" {
  description = "CA Certificate of the GKE Cluster"
  value       = google_container_cluster.primary.master_auth.cluster_ca_certificate
}

output "storage_bucket_name" {
  description = "Name of the game assets storage bucket"
  value       = google_storage_bucket.game_assets.name
}

output "load_balancer_ip" {
  description = "IP address of the load balancer"
  value       = google_compute_global_address.lb_ip.address
}
