module "gke" {
  source     = "../modules/gke/"
  gke_config = var.gke_config
} 