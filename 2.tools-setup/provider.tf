provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

provider "vault" {
    address = "https://dev-vault.${var.google_domain_name}/"
    token = file(pathexpand("${path.module}/vault-token.txt"))
}