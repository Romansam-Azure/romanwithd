variable "private_dns_zones" {
  type    = list(string)
}

variable "resource_group_name" {
  type = string
}

variable "virtual_network_id" {
  description = "The full Azure resource ID of the remote virtual network."
}

variable "virtual_network_name" {
  description = "virtual_network_name remote virtual network."
}

variable "registration_enabled" {
  description = "True or False."
  default     = false
}