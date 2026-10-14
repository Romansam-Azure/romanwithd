variable "nsg_name" {
  type        = string
  description = "Name of the NSG"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "security_rules" {
  type = any
}

variable "tags" {
  type        = map(string)
  description = "Tags for the NSG"
}