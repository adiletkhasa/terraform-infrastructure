resource "random_password" "password" {
  length           = 32
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "vault_generic_secret" "db-user" {
  path = "company_passwords/dev/user/db-user2"

  data_json = <<EOT
{
  "username":   "akhasanov",
  "password": "${random_password.password.result}"
}
EOT
}