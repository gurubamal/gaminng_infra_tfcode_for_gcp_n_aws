variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "The GCP zone"
  type        = string
  default     = "us-central1-a"
}

variable "network_name" {
  description = "Name of the VPC network"
  type        = string
  default     = "gaming-vpc"
}

variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
  default     = "gaming-subnet"
}

variable "ip_cidr_range" {
  description = "The IP CIDR range for the subnet"
  type        = string
  default     = "10.0.0.0/16"
}

variable "gke_cluster_name" {
  description = "Name of the GKE cluster"
  type        = string
  default     = "gaming-gke-cluster"
}

variable "node_pool_name" {
  description = "Name of the GKE node pool"
  type        = string
  default     = "default-node-pool"
}

variable "node_count" {
  description = "Number of nodes in the node pool"
  type        = number
  default     = 3
}

variable "machine_type" {
  description = "Machine type for the GKE nodes"
  type        = string
  default     = "e2-standard-4"
}

variable "service_account_email" {
  description = "Service account email"
  type        = string
}
