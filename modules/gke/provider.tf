provider "google" {
  region = var.gke_config["region"]
  zone   = var.gke_config["zone"]
}
provider "google-beta" {
  region = var.gke_config["region"]
  zone   = var.gke_config["zone"]
}