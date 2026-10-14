variable "name" {}
variable "resource_group_name" {}
variable "location" {}
variable "log_analytics_workspace_id" {}
variable "disable_local_auth" { default = false }
variable "tags" { default = {} }