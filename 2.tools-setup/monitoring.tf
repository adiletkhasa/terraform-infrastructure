module "vault" {
  source             = "../modules/monitoring"
  google_domain_name = var.google_domain_name
  PROJECT_ID         = var.PROJECT_ID
  service_name       = "dev-vault"
}

module "argo" {
  source             = "../modules/monitoring"
  google_domain_name = var.google_domain_name
  PROJECT_ID         = var.PROJECT_ID
  service_name       = "argo"
}

