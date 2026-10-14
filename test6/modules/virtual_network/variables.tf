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

variable "virtual_networks" {
  type = map(object({
    address_space = list(string)
    dns_servers   = list(string)
    encryption_enabled = bool
    subnets = list(object({
      name                                 = string
      address_prefixes                     = list(string)
      nsg_name                             = string
      route_table_name                     = string
      private_endpoint_network_policies_enabled = bool
      private_link_service_network_policies_enabled = bool
      service_endpoints                    = list(string)
    }))
  }))
  description = "Map of virtual networks and their configurations"
}

variable "virtual_network_peerings" {
  type = map(object({
    name                      = string
    remote_virtual_network_id = string
  }))
  description = "Map of virtual network peerings"
}

variable "nsg_ids" {
  type        = map(string)
  description = "Map of NSG names to their IDs"
}

variable "route_table_ids" {
  type        = map(string)
  description = "Map of route table names to their IDs"
}