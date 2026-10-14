variable "name" {}
variable "resource_group_name" {}
variable "location" {}
variable "app_service_plan_id" {}
variable "storage_account_name" {}
variable "deployment_storage_container_name" {}
variable "application_insights_name" {}
variable "identity_id" {}
variable "identity_client_id" {}
variable "runtime_name" {}
variable "runtime_version" {}
variable "virtual_network_subnet_id" { default = "" }
variable "app_settings" { default = {} }
variable "tags" { default = {} }