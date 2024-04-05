module "cert-manager-terraform-k8s-namespace" {
  source = "../modules/terraform-k8s-namespace/"
  name   = "cert-manager"
}


module "cert-manager-terraform-helm" {
  source               = "../modules/terraform-helm/"
  deployment_name      = "cert-manager"
  deployment_namespace = module.cert-manager-terraform-k8s-namespace.namespace
  chart                = "cert-manager"
  chart_version        = var.cert-manager-config["chart_version"]
  repository           = "https://charts.jetstack.io"
  values_yaml          = <<EOF
podDnsPolicy: "None"
podDnsConfig:
  nameservers:
    - "8.8.4.4"
    - "8.8.8.8"
installCRDs: true
EOF
}
