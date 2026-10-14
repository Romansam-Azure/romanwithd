variable "name" {}
variable "resource_group_name" {}
variable "location" {}
variable "identity_principal_id" {}
variable "function_principal_id" {}
variable "postgres_admin_username" {}
variable "postgres_admin_password" { sensitive = true }
variable "tags" { default = {} }