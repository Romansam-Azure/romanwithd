variable "resource_group_name" {
  description = "Name of the resource group where App Services are deployed"
  type        = string
}

variable "location" {
  description = "Azure region for the App Services"
  type        = string
}

variable "deployment_id" {
  description = "Unique deployment ID for naming resources"
  type        = string
}

variable "sitecore_sku" {
  description = "SKU for the App Service Plans (e.g., Extra Small, Small, PremiumV3)"
  type        = string
  validation {
    condition     = contains(["Extra Small", "Small", "Medium", "Large", "PremiumV3"], var.sitecore_sku)
    error_message = "Invalid Sitecore SKU. Allowed values: Extra Small, Small, Medium, Large, PremiumV3."
  }
}

variable "deploy_platform" {
  description = "Whether to deploy Sitecore platform roles (si, cm, cd, prc)"
  type        = bool
}

variable "deploy_xconnect" {
  description = "Whether to deploy xConnect services"
  type        = bool
}

variable "deploy_exm_dds" {
  description = "Whether to deploy EXM Dedicated Dispatch service"
  type        = bool
}

variable "app_service_plans" {
  description = "Map of App Service Plans for Sitecore roles and services"
  type = map(object({
    name = string
    sku  = string
  }))
}

variable "sitecore_roles" {
  description = "Map of Sitecore roles (si, cm, cd, prc) with their configurations"
  type = map(object({
    name   = string
    plan   = string
    deploy = bool
  }))
}

variable "xconnect_services" {
  description = "Map of xConnect services with their configurations"
  type = map(object({
    name   = string
    plan   = string
    deploy = bool
  }))
}

variable "sql_server_fqdn" {
  description = "Fully qualified domain name of the SQL Server"
  type        = string
}

variable "min_tls_version" {
  description = "Minimum TLS version for App Services"
  type        = string
  default     = "1.2"
}

variable "autoscale_settings" {
  description = "Auto-scaling settings for App Service Plans"
  type = map(object({
    enabled           = bool
    min_capacity      = number
    max_capacity      = number
    default_capacity  = number
    cpu_threshold     = number
  }))
  default = {}
}

variable "storage_account_id" {
  description = "The resource ID of the existing storage account for WDP storage"
  type        = string
}