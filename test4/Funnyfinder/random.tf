resource "random_id" "token" {
  byte_length = 4
}

resource "random_password" "admin" {
  length  = 32
  special = true
}