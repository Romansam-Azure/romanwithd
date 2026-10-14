# AVD Variables

variable "resource_group_name" {}
variable "vnet_name" {}
variable "subnet_name" {}

variable "key_vault_name" {}
variable "key_vault_resource_group" {}
variable "key_vault_secret_name" {}

variable "host_pool_name" {}
variable "vmhost_name" {}
variable "friendly_name" {}
variable "scaling_name" {}
variable "applicationgroupname" {}
variable "workspacename" {}
variable "location" {}
variable "vm_count" {
  type = number
}
variable "vm_size" {}
variable "admin_username" {}
variable "enable_scaling_plan" {
  description = "Whether to enable AVD scaling plan."
  type        = bool
  default     = false
}
variable "vnetresourcegroupname" {}

variable "subscriptionProd" {
  type        = string
  description = "Subscription ID for Production environment"
}

variable "vmhost_name2" {
  type    = string
  default = ""
  description = "VmHost name"
}

variable "vmhost_name3" {
  type    = string
  default = ""
  description = "Vmhost name"
}

variable "vmhost_name4" {
  type    = string
  default = ""
  description = "Vmhost name"
}

variable "applicationgroupname2" {
  type    = string
  default = ""
  description = "applicationgroupname"
}

variable "applicationgroupname3" {
  type    = string
  default = ""
  description = "applicationgroupname"
}

variable "applicationgroupname4" {
  type    = string
  default = ""
  description = "applicationgroupname"
}

variable "friendly_name2" {
  type    = string
  default = ""
  description = "Friendly name"
}

variable "friendly_name3" {
  type    = string
  default = ""
  description = "Friendly name"
}

// variable "vmhost_name_uat" {}
// variable "friendly_name_uat" { }
// variable "host_pool_name_uat" { }
// variable "applicationgroupname_uat" { }

variable "host_pool_name3" {
  type    = string
  default = ""
  description = "Host Pool name"
}

variable "host_pool_name2" {
  type    = string
  default = ""
  description = "Host pool name"
}


variable "existing_workspace_id" {
  type        = string
  description = "Workspace ID to associate with if create_workspace is false"
  default     = ""
}

variable "key_vault_id" {
  description = "ID of the existing Key Vault"
  type        = string
  default     = ""
}

variable "log_analytics_workspace_name" {
  description = "Name of the Log Analytics workspace"
  type        = string
}

variable "log_analytics_sku" {
  description = "SKU for the Log Analytics workspace"
  type        = string
}

variable "retention_in_days" {
  description = "Retention period in days for logs in the Log Analytics workspace"
  type        = number
}