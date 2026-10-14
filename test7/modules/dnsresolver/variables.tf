variable "resource_group_name" {
  description = "The name of the resource group in which to create the Private DNS Resolver."
  type        = string
}

variable "location" {
  description = "The Azure region where the resources will be created."
  type        = string
}

variable "dns_resolver_name" {
  description = "The name of the Private DNS Resolver."
  type        = string
}

variable "virtual_network_id" {
  description = "The ID of the Virtual Network in which the Private DNS Resolver will be created."
  type        = string
}

variable "inbound_endpoint_name" {
  description = "The name of the inbound endpoint for the Private DNS Resolver."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet where the inbound endpoint will be created."
  type        = string
}

