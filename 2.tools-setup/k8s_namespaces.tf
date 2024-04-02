
# create test namespaces

module "application-terraform-k8s-namespace" {
  source = "../modules/terraform-k8s-namespace/"
  name   = "application"
}