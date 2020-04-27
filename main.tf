terraform {
  backend "gcs" {
    bucket = "terrafrom-muralipoc-test"
    prefix = "demos"
    credentials = "/root/account.json"
  }
}

provider "google" {
  credentials = file("/root/account.json")
  project     = "terraform-275509"
  region      = "us-central1"
  zone        = "us-central1-c"
}


resource "google_compute_instance" "vm_instance" {
  name         = "test"
  machine_type = "n1-standard-1"

  boot_disk {
      initialize_params {
        image = "ubuntu-os-cloud/ubuntu-1804-lts"
                      }
            }

metadata_startup_script = "sudo apt-get -y update; sudo apt-get -y dist-upgrade ; sudo apt-get -y install nginx"

metadata = {
   ssh-keys = "demo:${file("/root/terraform/demo.pub")}"
  }

  network_interface {
    network = "default"
    access_config {
      // Ephemeral IP
    }
  }
}
  resource "google_compute_firewall" "default" {
  name    = "demo-firewall"
  network = "default"

  allow {
  protocol = "tcp"
  ports    = ["80"]
  }

  allow {
  protocol = "icmp"
  }
}

output "machinename" {
  value = "${google_compute_instance.vm_instance.network_interface.0.access_config.0.nat_ip}"
}
