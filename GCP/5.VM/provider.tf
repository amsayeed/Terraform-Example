terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.85.0"
    }
  }
}

provider "google" {
  # Configuration options
  project = "terraform-gcp-test-410510"
  region = "us-central1"
  zone = "us-central1-a"
  credentials = "/Users/ahmedsayed/VS_Projects/Terraform/GCP/keys.json"
}