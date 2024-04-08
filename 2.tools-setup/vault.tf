module "vault-terraform-k8s-namespace" {
  source = "../modules/terraform-k8s-namespace/"
  name   = "vault"
}

module "vault-terraform-helm" {
  source               = "../modules/terraform-helm/"
  deployment_name      = "vault"
  deployment_namespace = module.vault-terraform-k8s-namespace.namespace
  chart                = "vault"
  repository           = "https://helm.releases.hashicorp.com"
  chart_version        = var.vault-config["chart_version"]
  values_yaml          = <<-EOF
server:
    ingress:
      enabled: true
      annotations: 
        nginx.ingress.kubernetes.io/proxy-body-size: "0"
        ingress.kubernetes.io/ssl-redirect: "false"
        acme.cert-manager.io/http01-edit-in-place: "true"
        cert-manager.io/cluster-issuer: letsencrypt-dev
      ingressClassName: "nginx"
      hosts:
      - host: "dev-vault.${var.google_domain_name}"
        http:
          paths: 
          - pathType: Prefix
            path: "/"
            backend:
              service:
                name: vault
                port:
                  number: 8200
      tls:
       - secretName: vault-tls
         hosts:
          - "dev-vault.${var.google_domain_name}"
  EOF
}
