variable "name" {}
variable "resource_group_name" {}
variable "location" {}
variable "sku" {}
variable "kind" { default = "functionapp" }
variable "tags" { default = {} }