provider "vault" {
    address = "https://dev-vault.adilet-khasanov.net/"
    token =  file(pathexpand("${path.module}/vault-token.txt"))
}