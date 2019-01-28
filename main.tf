resource "google_compute_instance_group" "elasticsearch-cluster" {
  name        = "elasticsearch-cluster"
  description = "Terraform test instance group"

  instances = [
    "${google_compute_instance.lalit-efk-compute-instance.*.self_link}"
  ]

  named_port {
    name = "elasticsearch-api"
    port = "9200"
  }

  zone = "us-east1-b"
}

resource "google_compute_forwarding_rule" "elasticsearch-forwarding-rule" {
  name   = "elasticsearch-lb"
  load_balancing_scheme = "INTERNAL"
  backend_service = "${google_compute_region_backend_service.elasticsearch-lb.self_link}"
  ports  = [ "9200"]
}

resource "google_compute_region_backend_service" "elasticsearch-lb" {
  name             = "elasticsearch-lb"
  protocol         = "TCP"
  timeout_sec      = 10
  session_affinity = "NONE"

  backend {
    group = "${google_compute_instance_group.elasticsearch-cluster.self_link}"
  }

  health_checks = ["${google_compute_health_check.elasticsearch-healthcheck.self_link}"]
}

resource "google_compute_health_check" "elasticsearch-healthcheck" {
  name               = "elasticsearch-healthcheck"
  check_interval_sec = 5
  timeout_sec        = 5

  tcp_health_check {
    port = "9200"
  }
}
