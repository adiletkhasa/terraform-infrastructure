provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

provider "vault" {
    address = "https://dev-vault.adilet-khasanov.net/"
    token = "${path.module}/vault_token.txt"
}