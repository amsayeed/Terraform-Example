/**
 * This Terraform configuration creates a Google Cloud Storage bucket and uploads a picture to it.
 * The bucket is named "tf-course-bucket-from-terraform" and is located in the "US-CENTRAL1" region.
 * It uses the "NEARLINE" storage class and has the following labels: "env" = "tf_env" and "dep" = "compliance".
 * The bucket has uniform bucket-level access enabled.
 * 
 * The bucket has a lifecycle rule that sets the storage class to "COLDLINE" for objects older than 5 days.
 * It also has a retention policy that locks the bucket and sets a retention period of 864000 seconds (10 days).
 * 
 * The configuration also uploads a picture named "vodafone_logo" to the bucket, with the source file "vodafone.jpg".
 */

// This resource block creates a Google Cloud Storage bucket with the specified configurations
resource "google_storage_bucket" "GCS1" {
    // The name of the bucket
    name                      = "tf-test-bucket-from-terraform-to-upload-file"

    // Storage class for the bucket
    // NEARLINE is a low-cost, highly durable storage service for storing infrequently accessed data
    storage_class             = "NEARLINE"

    // The geographical region where bucket is located
    location                  = "US-CENTRAL1"

    // Labels for the bucket, these can be useful for organization and billing
    labels = {
        "env" = "tf_env"
        "dep" = "compliance"
    }

    // Enable uniform bucket-level access which means access checks only use bucket-level IAM policies or ACLs
    uniform_bucket_level_access = true

    // Lifecycle rules for objects in the bucket
    lifecycle_rule {
        // Condition for lifecycle rule, here it's age of object in days
        condition {
            age = 5
        }

        // Action to take when condition is met
        // In this case, the storage class changes to COLDLINE for objects older than 5 days
        action {
            type          = "SetStorageClass"
            storage_class = "COLDLINE"
        }
    }


}

// This resource block uploads the specified object to the bucket
resource "google_storage_bucket_object" "file" {
    // The name of the object once uploaded to the bucket
    name   = "data_txt"

    // The name of bucket, to which object will be uploaded
    bucket = google_storage_bucket.GCS1.name

    // Source file to upload
    source = "data.txt"
}