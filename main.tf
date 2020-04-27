provider "google" {
  credentials = "${file("/root/account.json")}"
  project     = "terraform-275509"
  region      = "us-central1"
  zone        = "us-central1-c"
}

resource "google_compute_instance" "vm_instance" {
  name         = "test"
  machine_type = "n1-standard-1"
  
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
  value = "${google_compute_instance.vm_instance.network_interface.*.access_config[0]}"
}
