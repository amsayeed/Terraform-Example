resource "google_bigquery_dataset" "example_dataset" {
  dataset_id                  = "example_dataset"
  location                    = "US"
  description                 = "This is an example dataset."
}

resource "google_bigquery_table" "example_table" {
  dataset_id = google_bigquery_dataset.example_dataset.dataset_id
  table_id   = "example_table"

  schema = <<EOF
[
  {
    "name": "id",
    "type": "INTEGER",
    "mode": "REQUIRED"
  },
  {
    "name": "data",
    "type": "STRING",
    "mode": "NULLABLE"
  }
]
EOF
}
/*
resource "google_bigquery_dataset_iam_binding" "example_binding" {
  dataset_id = google_bigquery_dataset.example_dataset.dataset_id
  role       = "roles/bigquery.dataEditor"

  members = [
    "user:jane.doe@example.com",
    "serviceAccount:your-service-account@example.iam.gserviceaccount.com",
  ]
}
*/