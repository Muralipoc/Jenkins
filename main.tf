terraform {
  backend "gcs" {
    bucket = "terraform-bucket-murali"
    prefix  = "terraform/state"
    region = "us-east1"
  }
}

resource "google_compute_instance" "default" {
  project      = "test-jenkins-275418"
  name         = "test"
  machine_type = "n1-standard-1"
  zone         = "us-east1"

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

  metadata = {
    foo = "bar"
  }

  metadata_startup_script = "echo hi > /test.txt"

}

output "machinename" {
  value = "${google_compute_instance.default.network_interface.network_ip}"
}
