variable "environment" {
  type        = string
  description = "PRD or UAT"
  validation {
    condition     = contains(["PRD", "UAT"], var.environment)
    error_message = "Environment must be PRD or UAT."
  }
}

variable "location" {
  type    = string
  default = "Australia East"
}

variable "prefix" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "vnet_address_space" {
  type = list(string)
}

variable "private_endpoint_subnet_prefix" {
  type = string
}

variable "app_service_subnet_prefix" {
  type = string
}

variable "private_dns_resource_group_name" {
  type        = string
  description = "Resource group that contains the existing Private DNS zones"
}

variable "app_service_plan_sku" {
  type = string
}

variable "postgresql_sku" {
  type = string
}

variable "postgresql_storage_mb" {
  type = number
}

variable "postgresql_ha_mode" {
  type = string # ZoneRedundant or SameZone
}

variable "postgresql_admin_login" {
  type      = string
  sensitive = true
}

variable "postgresql_admin_password" {
  type      = string
  sensitive = true
}

variable "storage_account_nextjs_name" {
  type = string
}

variable "storage_account_media_name" {
  type = string
}

variable "app_service_nextjs_name" {
  type = string
}

variable "app_service_strapi_name" {
  type = string
}

variable "postgresql_name" {
  type = string
}

variable "key_vault_name" {
  type = string
}

variable "log_analytics_name" {
  type = string
}

variable "app_insights_name" {
  type = string
}

variable "redshield_ip_ranges" {
  type = list(string)
}

variable "tags" {
  type    = map(string)
  default = {}
}