variable "environment_name" {
  type = string
}

variable "location" {
  type    = string
  default = "eastus2"
}

variable "skip_vnet" {
  type    = bool
  default = false
}

variable "resource_group_name" {
  type    = string
  default = ""
}

variable "api_service_name" {
  type    = string
  default = ""
}

variable "web_service_name" {
  type    = string
  default = ""
}

variable "storage_sku_name" {
  type    = string
  default = "Standard_LRS"
}

variable "disable_local_auth" {
  type    = bool
  default = true
}

variable "administrator_login_name" {
  type    = string
  default = "ffpostgresadmint"
}

variable "administrator_login_password" {
  type      = string
  sensitive = true
  default   = null
}