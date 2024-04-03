module "external-dns-terraform-k8s-namespace" {
  source = "../modules/terraform-k8s-namespace/"
  name   = "external-dns"
}


resource "google_service_account" "external-dns" {
  account_id   = "pro-external-dns"
  display_name = "Used for external-dns"
  project      = var.PROJECT_ID
}

resource "google_service_account_key" "external-dns" {
  service_account_id = google_service_account.external-dns.name
  public_key_type    = "TYPE_X509_PEM_FILE"
}


resource "google_project_iam_binding" "externald-dns" {
  project = var.PROJECT_ID
  role    = "roles/dns.admin"
  members = [
    "serviceAccount:${google_service_account.external-dns.email}"
  ]
}



resource "kubernetes_secret" "external_dns_secret" {
  metadata {
    name      = "external-dns"
    namespace = module.external-dns-terraform-k8s-namespace.namespace
  }
  data = {
    "credentials.json" = base64decode(google_service_account_key.external-dns.private_key)
  }
  type = "generic"
}



module "external-dns-terraform-helm" {
  depends_on = [
    kubernetes_secret.external_dns_secret
  ]
  source               = "../modules/terraform-helm/"
  deployment_name      = "external-dns"
  deployment_namespace = module.external-dns-terraform-k8s-namespace.namespace
  chart                = "external-dns"
  chart_version        = var.external-dns-config["chart_version"]
  repository           = "https://charts.bitnami.com/bitnami"
  values_yaml          = <<EOF
provider: google
google:
  project: "${var.PROJECT_ID}"
  serviceAccountSecret: external-dns 
rbac:
  create: true
EOF
}
