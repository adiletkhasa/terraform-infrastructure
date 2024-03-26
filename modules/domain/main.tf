resource "google_dns_managed_zone" "project" {
  name     = "hosted-zone"
  dns_name = "${var.google_domain_name}."
}

variable "google_domain_name" {
  type        = string
  description = "Please find it in Route53"
}