variable "name" {}
variable "resource_group_name" {}
variable "location" {}
variable "sku_name" {}
variable "tier" {}
variable "version" {}
variable "administrator_login" {}
variable "administrator_password" { sensitive = true }
variable "geo_redundant_backup" { default = true }
variable "high_availability" {}
variable "databases" { default = [] }
variable "user_assigned_identity_id" {}
variable "subnet_id" { default = null }
variable "private_dns_zone_id" { default = null }
variable "tags" { default = {} }