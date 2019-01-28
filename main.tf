resource "google_compute_global_forwarding_rule" "http" {
  project    = "${var.project}"
  count      = "${var.http_forward ? 1 : 0}"
  name       = "${var.name}"
  target     = "${google_compute_target_http_proxy.default.self_link}"
  ip_address = "${google_compute_global_address.default.address}"
  port_range = "80"
  depends_on = ["google_compute_global_address.default"]
}
