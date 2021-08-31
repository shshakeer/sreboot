resource "google_storage_bucket" "sreboot_bucket" {
name     = var.bucket_name
location = var.region
}

terraform {
  backend "gcs" {
    bucket         = "srebootstatefile"
    prefix         = "sreboot-website"
  }
}
