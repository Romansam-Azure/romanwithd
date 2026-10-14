# sitecore-xp-deployment/modules/service_bus/variables.tf

variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "namespace_name" { type = string }
variable "sku_name" { type = string }
variable "queues" { type = list(string) }
variable "min_tls_version" { type = string }