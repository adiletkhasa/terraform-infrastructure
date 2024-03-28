
# create test namespaces

module "cert-manager-terraform-k8s-namespace" {
  source = "../modules/terraform-k8s-namespace/"
  name   = "application"
}