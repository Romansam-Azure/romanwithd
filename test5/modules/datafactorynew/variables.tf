variable "data_factory_name" {
  description = "The name of the Data Factory"
  type        = string
}

variable "location" {
  description = "The location of the Data Factory"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "subnet_id" {
  description = "Subnet of pep"
}

variable "dataf_pep_name" {
  description = "datafactory pep  name"
}

variable "dataf_pep_nic_name" {
  description = "datafactory pep nic name"
}

variable "private_dataf_dns_zone_ids" {
  description = "Privatelinkname for dataf"
}

variable "pep_resource_group_name" {
  description = "Resource Group for stirage pep"
  default = "rg-network-pom-aue-001"
}

