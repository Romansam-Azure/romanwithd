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

variable "network_security_groups" {
  type = map(object({
    rules = list(object({
      name                       = string
      priority                   = number
      direction                  = string        # "Inbound" or "Outbound"
      access                     = string        # "Allow" or "Deny"
      protocol                   = string        # "Tcp", "Udp", or "*"
      source_port_range           = string
      destination_port_range      = optional(string)
      destination_port_ranges     = optional(list(string))
      source_address_prefix       = string
      destination_address_prefix  = string
    }))
  }))
  description = "Map of NSGs and their associated security rules"
}
