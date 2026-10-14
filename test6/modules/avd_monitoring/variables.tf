variable "resource_group_name" {
  description = "Name of the resource group for the Log Analytics workspace"
  type        = string
}

variable "location" {
  description = "Azure region for the resources"
  type        = string
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

variable "host_pool_ids" {
  description = "List of AVD host pool resource IDs"
  type        = list(string)
  default     = []
}

variable "application_group_ids" {
  description = "List of AVD application group resource IDs"
  type        = list(string)
  default     = []
}

variable "workspace_ids" {
  description = "List of AVD workspace resource IDs"
  type        = list(string)
  default     = []
}

variable "scaling_plan_ids" {
  description = "Map of scaling plan names to scaling plan resource IDs"
  type        = map(string)
}

variable "diagnostic_setting_prefix" {
  description = "Prefix for diagnostic setting names"
  type        = string
  default     = "avd-monitoring"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

# New: Variables for Session Host Monitoring
variable "data_collection_rule_name" {
  description = "Name of the Data Collection Rule for session hosts"
  type        = string
  default     = "microsoft-avdi-australiaeast"
}

variable "dcr_resource_group_name" {
  description = "Resource group for the DCR (defaults to module RG if null)"
  type        = string
  default     = null
}

variable "session_host_workspace_id" {
  description = "Log Analytics workspace ID for session host data (defaults to main LAW if null)"
  type        = string
  default     = null
}

variable "deploy_ama_extension" {
  description = "Whether to deploy the Azure Monitor Agent extension to session hosts"
  type        = bool
  default     = true
}

variable "session_host_ids" {
  description = "List of AVD Session Host VM resource IDs"
  type        = list(string)
  default     = []
}