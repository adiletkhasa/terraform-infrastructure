module "prometheus-terraform-k8s-namespace" {
  source = "../modules/terraform-k8s-namespace/"
  name   = "prometheus"
}


module "prometheus-terraform-helm" {
  source               = "../modules/terraform-helm/"
  deployment_name      = "prometheus"
  deployment_namespace = module.prometheus-terraform-k8s-namespace.namespace
  chart                = "prometheus"
  chart_version        = var.prometheus-config["chart_version"]
  repository           = "https://prometheus-community.github.io/helm-charts"
  values_yaml          = <<EOF

server:
  enabled: true
  ingress:
    enabled: true
  annotations:
      ingress.kubernetes.io/ssl-redirect: "false"
      kubernetes.io/ingress.class: nginx
      cert-manager.io/cluster-issuer: letsencrypt-dev
      acme.cert-manager.io/http01-edit-in-place: "true"
    hosts: 
      - "prometheus.${var.google_domain_name}"
    tls:
      - secretName: prometheus-server-tls
        hosts:
          - "prometheus.${var.google_domain_name}"

EOF
}