module "" {
  source = "../modules/terraform-k8s-namespace/"
  name   = ""
}

resource "google_service_account" "service_account" {
  account_id   = "project-external-dns"
  display_name = "Service Account"
  project      = var.PROJECT_ID
}

module "external-dns-terraform-helm" {
  source               = "../modules/terraform-helm/"
  deployment_name      = "external-dns"
  deployment_namespace = module.ingress-terraform-k8s-namespace.namespace
  chart                = "external-dns"
  chart_version        = var.external-dns-config["chart_version"]
  repository           = "https://charts.bitnami.com/bitnami"
  values_yaml          = <<EOF
  provider: google
  google:
    project: "${var.PROJECT_ID}"
    serviceAccountSecret: ""
  EOF
}