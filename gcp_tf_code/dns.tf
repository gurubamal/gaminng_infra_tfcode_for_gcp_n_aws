resource "google_dns_managed_zone" "public_zone" {
  name        = "gaming-public-zone"
  dns_name    = "gaming-company.com."
  description = "Public DNS zone for the gaming platform"
}

