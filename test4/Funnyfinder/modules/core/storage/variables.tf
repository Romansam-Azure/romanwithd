variable "name" {}
variable "resource_group_name" {}
variable "location" {}
variable "sku" {}
variable "containers" { default = [] }
variable "public_network_access" { default = "Enabled" }
variable "network_acls" { default = {} }
variable "tags" { default = {} }