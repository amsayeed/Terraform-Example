resource "google_compute_network" "vpc_network" {
  name                    = "windows-vm-network"
  auto_create_subnetworks = true
}

resource "google_compute_firewall" "firewall" {
  name    = "allow-rdp"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_instance" "windows_instance" {
  name         = "windows-vm"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "windows-cloud/windows-2019"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    windows-startup-script-ps1 = "enable-psremoting -force"
  }

  service_account {
    scopes = ["cloud-platform"]
  }
}

output "instance_ip_addr" {
  value = google_compute_instance.windows_instance.network_interface[0].access_config[0].nat_ip
}
