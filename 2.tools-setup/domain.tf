module "google-domain" {
  source             = "../modules/domain"
  google_domain_name = var.google_domain_name
}