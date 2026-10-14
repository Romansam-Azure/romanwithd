variable "subnet_id" {
  description = "The ID of the Subnet from which Private IP Addresses will be allocated for this Private Endpoint."
  type        = string
}

variable "location" {
  description = "The location of the new resource"
  type        = string
  default     = "australiaeast"
}

variable "pe_resource_name" {
  description = "Name of the resource the private link is for connecting to. eg. mystorageaccount."
  type        = string
}

variable "pe_resource_group_name" {
  description = "The name of the Resource group where the the Private Endpoint resource will be created."
  type        = string
}

variable "private_dns_zone_ids" {
  description = "A list of resource ID's of the private DNS zone where the A record is created, this could be in another subscription, see https://docs.microsoft.com/en-us/azure/private-link/private-endpoint-dns#azure-services-dns-zone-configuration"
  type        = list(string)
  default     = null
}

variable "endpoint_resource_id" {
  description = "The resourceID of the Azure resource that the new Private Endpoint will be assigned to."
  type        = string
}

variable "subresource_names" {
  description = "Sub resource the private link provides access to. See https://docs.microsoft.com/en-us/azure/private-link/private-endpoint-overview#private-link-resource"
  type        = list(string)
  default     = null
}

variable "tags" {
  description = "The tags for the private endpoint and the associated NIC"
  type        = map(string)
  default     = {}
}
