variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Azure region for the resources"
  default     = "australiasoutheast"
}

variable "common_tags" {
  type        = map(string)
  description = "Common tags for all resources"
}

variable "route_tables" {
  type = map(object({
    routes = list(object({
      name                   = string
      address_prefix         = string
      next_hop_type          = string
      next_hop_in_ip_address = optional(string)   # optional
    }))
  }))
  description = "Map of route tables and their routes"
}