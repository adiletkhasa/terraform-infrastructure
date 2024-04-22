module "argo-terraform-k8s-namespace" {
  source = "../modules/terraform-k8s-namespace/"
  name   = "argo"
}

module "argo-terraform-helm" {
  source               = "../modules/terraform-helm/"
  deployment_name      = "argo"
  deployment_namespace = module.argo-terraform-k8s-namespace.namespace
  chart                = "argo-cd"
  repository           = "https://argoproj.github.io/argo-helm"
  chart_version        = var.argo-config["chart_version"]
  values_yaml          = <<-EOF


server:
  ingress:
    enabled: true
    annotations: 
      ingress.kubernetes.io/ssl-redirect: "true"
      kubernetes.io/ingress.class: nginx
      acme.cert-manager.io/http01-edit-in-place: "true"
      nginx.ingress.kubernetes.io/backend-protocol: "HTTPS"
    hosts: 
      - "argo.${var.google_domain_name}"
    paths:
      - /
    pathType: Prefix
    tls: 
      - secretName: argocd-secret
        hosts:
          - "argo.${var.google_domain_name}"
    https: true
  EOF
}


data "kubernetes_secret" "example" {
  depends_on = [
    module.argo-terraform-helm
  ]
  metadata {
    name      = "argocd-initial-admin-secret"
    namespace = "argo"
  }
}

resource "vault_generic_secret" "argo-user" {
  path = "company_passwords/dev/argocd/argocd_admin"

  data_json = <<EOT
{
  "username":   "admin",
  "password": "${data.kubernetes_secret.example.data["password"]}"
}
EOT
}