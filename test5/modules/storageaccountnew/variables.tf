variable "saResourceGroup" {
  type        = string
  description = "resource group name"
}

variable "location" {
  description = "location"
  type        = string
}

variable "storageAccountName" {
  type        = string
  description = "storage account name"
}

variable "account_tier" {
  type        = string
  description = "storage account tier"
}

variable "account_replication_type" {
  type        = string
  description = "account replication type"
}

variable "allow_nested_items_to_be_public" {
  type        = string
  description = "allow nested items to be public"
}

variable "min_tls_version" {
  type        = string
  description = "account blob public access"
}

variable "infrastructure_encryption_enabled" {
  type        = string
  description = "Encryption enable"
}

variable "is_hns_enabled" {
  type        = string
  description = "hns enabled"
}

variable "blob_soft_delete_retention_days" {
  type        = string
  description = "blob_soft_delete_retention_days"
}


variable "envTag" {
  type = map(string)
  description = "Enviroment Tags"
}


variable "subnet_id" {
  description = "location of keyvault"
}

variable "storage_pep_name" {
  description = "storage pep  name"
}

variable "sto_pep_nic_name" {
  description = "storage pep nic name"
}

variable "private_blob_dns_zone_ids" {
  description = "Privatelinkname for blob"
}


variable "pep_resource_group_name" {
  description = "Resource Group for stirage pep"
  default = "rg-network-pom-aue-001"
}