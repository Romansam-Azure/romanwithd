variable "name" {
  description = "Name of the storage account (3-24 characters, lowercase, numbers only)"
  type        = string
}

variable "location" {
  description = "Azure region for the storage account"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "file_share_name" {
  description = "Name of the FSLogix file share"
  type        = string
  default     = "fslogix"
}

variable "quota_in_gb" {
  description = "Size of the file share in GB (minimum 100GB for Premium)"
  type        = number
  default     = 128
}

variable "replication_type" {
  description = "Storage replication type (LRS, ZRS, GRS, GZRS)"
  type        = string
  default     = "LRS"
  
  validation {
    condition     = contains(["LRS", "ZRS", "GRS", "GZRS"], var.replication_type)
    error_message = "Replication type must be one of: LRS, ZRS, GRS, GZRS."
  }
}

variable "enable_infrastructure_encryption" {
  description = "Enable Azure Storage infrastructure encryption"
  type        = bool
  default     = false
}

variable "allowed_subnets" {
  description = "List of subnet IDs allowed to access the storage account"
  type        = list(string)
  default     = []
}

variable "ip_whitelist" {
  description = "List of IP addresses allowed to access the storage account"
  type        = list(string)
  default     = []
}

variable "enable_private_endpoint" {
  description = "Enable private endpoint for the storage account"
  type        = bool
  default     = true
}

variable "private_endpoint_subnet_id" {
  description = "Subnet ID for the private endpoint"
  type        = string
  default     = null
}

variable "private_dns_zone_id" {
  description = "Private DNS Zone ID for privatelink.file.core.windows.net"
  type        = string
  default     = ""
}

variable "role_assignment_principal_id" {
  description = "Entra ID principal ID to assign Storage File Data SMB Share Contributor role"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}