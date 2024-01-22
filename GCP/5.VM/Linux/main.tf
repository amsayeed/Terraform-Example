// The 'provider' block configures the named provider.
provider "google" {
  // Take note that you need to replace 'your-gcp-project-id' with your actual Google Cloud Platform project ID.
  project = "your-gcp-project-id"

  // You replace 'your-region' with the region where the resources should be activated.
  region  = "your-region"
}

// This resource block sets up a compute instance, where the 'google_compute_instance' is the COMPUTE INSTANCE.
resource "google_compute_instance" "nginx_instance" {
  // This is the name of the compute instance.
  name         = "nginx-instance"

  // This is the machine's type specification.
  machine_type = "e2-medium"

  // Specify the zone here, replace 'your-zone' with your actual zone.
  zone         = "your-zone"

  // The 'boot_disk' block specifies the disk that will be attached to the instance.
  boot_disk {
    initialize_params {
      // This is the image that will be used to boot the disk.
      image = "debian-cloud/debian-9"
    }
  }

  // 'network_interface' block sets up a network interface for the instance.
  network_interface {
    network = "default"
    access_config {
      // Ephemeral IP
    }
  }

  // This script will run at startup.
  // It will install Nginx, start the service and create a basic page.
  metadata_startup_script = <<-EOS
    #!/bin/bash
    apt-get update
    apt-get install -y nginx
    service nginx start
    echo 'Hello from Nginx on GCP!' > /var/www/html/index.nginx-debian.html
  EOS

  // These tags will be used to associate firewall rules with the instance.
  tags = ["http-server", "https-server"]
}

// This resource will setup a firewall which will allow incoming connections on port 80 (HTTP) and 443 (HTTPS).
resource "google_compute_firewall" "default" {
  // This is the name of the firewall.
  name    = "nginx-firewall"

  // This is the network where the firewall will be activated.
  network = "default"

  // The 'allow' block specifies which protocols and ports will be open.
  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  // This will allow connections from any IP.
  source_ranges = ["0.0.0.0/0"]

  // The firewall rule will apply to instances with these tags.
  target_tags   = ["http-server", "https-server"]
}

// 'null_resource' is a resource that has no further action once created.
resource "null_resource" "copy_html" {
  // The 'depends_on' argument specifies that this resource relies on another one to be created first.
  depends_on = [google_compute_instance.nginx_instance]

  // 'provisioner' block specifies an action to take on the local machine running Terraform.
  provisioner "local-exec" {
    // This command will use ssh to copy a local HTML file to the compute instance once it has been created.
    command = "scp -i /path/to/your/private/key -o StrictHostKeyChecking=no /path/to/your/localfile.html ${google_compute_instance.nginx_instance.network_interface[0].access_config[0].nat_ip}:/var/www/html"
  }
}
