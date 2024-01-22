resource "google_pubsub_schema" "example" {
  name = "example-schema"
  type = "AVRO"
  definition = <<EOF
{
  "type" : "record",
  "name" : "SimpleOrder",
  "fields" : [
    {
      "name" : "order_id",
      "type" : "long"
    },
    {
      "name" : "customer_email",
      "type" : "string"
    },
    {
      "name" : "order_total",
      "type" : "string"
    },
    {
      "name" : "order_date",
      "type" : "string"
    },
    {
      "name" : "order_status",
      "type" : "string"
    },
    {
      "name" : "is_paid",
      "type" : "boolean"
    }
  ]
}
EOF
}


resource "google_pubsub_topic" "example" {
  name = "example-topic"

  depends_on = [google_pubsub_schema.example]
  schema_settings {
    schema = google_pubsub_schema.example.id
    encoding = "JSON"
  }
}


resource "google_pubsub_subscription" "example" {
  name  = "example-subscription"
  topic = google_pubsub_topic.example.id

  bigquery_config {
    table = "${google_bigquery_table.test.project}.${google_bigquery_table.test.dataset_id}.${google_bigquery_table.test.table_id}"
    use_topic_schema  = true
    drop_unknown_fields = true
  }

  depends_on = [google_project_iam_member.viewer, google_project_iam_member.editor]
}

data "google_project" "project" {
    project_id = "terraform-gcp-test-410510"
}

resource "google_project_iam_member" "viewer" {
  project = data.google_project.project.project_id
  role   = "roles/bigquery.metadataViewer"
  member = "serviceAccount:service-${data.google_project.project.number}@gcp-sa-pubsub.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "editor" {
  project = data.google_project.project.project_id
  role   = "roles/bigquery.dataEditor"
  member = "serviceAccount:service-${data.google_project.project.number}@gcp-sa-pubsub.iam.gserviceaccount.com"
}

resource "google_bigquery_dataset" "test" {
  dataset_id = "example_dataset"
}

resource "google_bigquery_table" "test" {
  deletion_protection = false
  table_id   = "example_table"
  dataset_id = google_bigquery_dataset.test.dataset_id
  time_partitioning {
    type = "DAY"
    expiration_ms = 2678400000  # 31 days in milliseconds
  }

    schema = jsonencode([
    {
      "name": "order_id",
      "type": "INTEGER",
      "mode": "REQUIRED"
    },
    {
      "name": "customer_email",
      "type": "STRING",
      "mode": "NULLABLE"
    },
    {
      "name": "order_total",
      "type": "STRING",
      "mode": "NULLABLE"
    },
    {
      "name": "order_date",
      "type": "STRING",
      "mode": "NULLABLE"
    },
    {
      "name": "order_status",
      "type": "STRING",
      "mode": "NULLABLE"
    },
    {
      "name": "is_paid",
      "type": "BOOLEAN",
      "mode": "NULLABLE"
    }
  ])
}