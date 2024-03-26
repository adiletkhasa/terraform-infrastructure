terraform {
  backend "gcs" {
    bucket = "terraform-project-akhasanov"
    prefix = "/dev/Users/adiletkhasanov/git-repositories/main-project/0.account_setup"
  }
}
