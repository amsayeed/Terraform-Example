#Create Bucket
#Upload index.zip
#deploy function
#policy binding

resource "google_storage_bucket" "fun_bucket" {
  name = "tf_fun_bucket_test"
  location = "US-CENTRAL1"
}

resource "google_storage_bucket_object" "srccode" {
  name = "fun.zip"
  bucket = google_storage_bucket.fun_bucket.name
  source = "fun.zip"
}

resource "google_cloudfunctions_function" "fun_from_tf" {
  name = "GetLocationData"
  runtime = "python38"
  description = "This is my first function from terraform script."

  available_memory_mb = 128
  source_archive_bucket = google_storage_bucket.fun_bucket.name
  source_archive_object = google_storage_bucket_object.srccode.name

  trigger_http = true
  entry_point = "hello_http"

}

resource "google_cloudfunctions_function_iam_member" "allowaccess" {
  region = google_cloudfunctions_function.fun_from_tf.region
  cloud_function = google_cloudfunctions_function.fun_from_tf.name

  role = "roles/cloudfunctions.invoker"
  member = "allUsers"

}
