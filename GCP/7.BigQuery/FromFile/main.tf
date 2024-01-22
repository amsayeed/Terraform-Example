resource "google_storage_bucket" "my_bucket" {
  name     = "from-file-my-bucket-name"
  location = "US"
}

resource "google_storage_bucket_object" "my_object" {
  name   = "all.csv"
  bucket = google_storage_bucket.my_bucket.name
  source = "/Users/ahmedsayed/VS_Projects/Terraform/GCP/7.BigQuery/FromFile/all.csv"
}

resource "google_bigquery_dataset" "my_dataset" {
  dataset_id                  = "Countries"
  friendly_name               = "test"
  description                 = "This is a test dataset."
  location                    = "US"

}

resource "google_bigquery_table" "my_table" {
  dataset_id = google_bigquery_dataset.my_dataset.dataset_id
  table_id   = "ISO_Countries"
  deletion_protection=false

  external_data_configuration {
    source_format = "CSV"
    autodetect    = true
    source_uris = [
      "gs://${google_storage_bucket.my_bucket.name}/${google_storage_bucket_object.my_object.name}",
    ]
  }
}
