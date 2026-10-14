variable "sqlResourceGroup" {
  type        = string
  description = "resource group name"
}


variable "location" {
  description = "location"
  type        = string
}

variable "sqlserver_name" {
  type        = string
  description = "storage account name"
}

variable "sql_username" {
  type        = string
  description = "storage account name"
}

variable "sql_password" {
  description = "SQL Server Administrator Password"
  type        = string
  sensitive   = true
  default     = ""
}

variable "subnet_id" {
  description = "Subnet of pep"
}

variable "sql_pep_name" {
  description = "storage pep  name"
}

variable "sql_pep_nic_name" {
  description = "storage pep nic name"
}

variable "private_sql_dns_zone_ids" {
  description = "Privatelinkname for sql"
}

variable "pep_resource_group_name" {
  description = "Resource Group for stirage pep"
  default = "rg-network-pom-aue-001"
}