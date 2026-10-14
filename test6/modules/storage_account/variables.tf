# Core Storage Account Variables
variable "name" {
  description = "Name of the storage account"
  type        = string
}

variable "location" {
  description = "Azure region for the resources"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}

# Storage Account Configuration
variable "account_kind" {
  description = "Kind of storage account (StorageV2 for Azure Files)"
  type        = string
  default     = "StorageV2"
}

variable "account_tier" {
  description = "Performance tier (Premium for FSLogix)"
  type        = string
  default     = "Premium"
}

variable "account_replication_type" {
  description = "Replication type (LRS for cost optimization)"
  type        = string
  default     = "LRS"
}

variable "enable_https_traffic_only" {
  description = "Require secure transfer for REST API operations"
  type        = bool
  default     = true
}

variable "min_tls_version" {
  description = "Minimum TLS version (TLS1_2 as required)"
  type        = string
  default     = "TLS1_2"
}

variable "public_network_access_enabled" {
  description = "Enable public network access"
  type        = bool
  default     = false
}

variable "cross_tenant_replication_enabled" {
  description = "Allow cross-tenant replication"
  type        = bool
  default     = false
}

variable "is_hns_enabled" {
  description = "Enable hierarchical namespace"
  type        = bool
  default     = false
}

variable "nfsv3_enabled" {
  description = "Enable NFSv3"
  type        = bool
  default     = false
}

variable "sftp_enabled" {
  description = "Enable SFTP"
  type        = bool
  default     = false
}

variable "default_to_oauth_authentication" {
  description = "Default to Microsoft Entra authorization"
  type        = bool
  default     = false
}

variable "shared_access_key_enabled" {
  description = "Enable storage account key access"
  type        = bool
  default     = true
}

variable "allow_nested_items_to_be_public" {
  description = "Allow anonymous access on containers"
  type        = bool
  default     = false
}

variable "infrastructure_encryption_enabled" {
  description = "Enable infrastructure encryption"
  type        = bool
  default     = false
}

// # Blob Properties
// variable "versioning_enabled" {
//   description = "Enable versioning for blobs"
//   type        = bool
//   default     = false
// }

// variable "change_feed_enabled" {
//   description = "Enable blob change feed"
//   type        = bool
//   default     = false
// }

// variable "blob_delete_retention_days" {
//   description = "Days to retain deleted blobs"
//   type        = number
//   default     = 0
// }

// variable "container_delete_retention_days" {
//   description = "Days to retain deleted containers"
//   type        = number
//   default     = 0
// }

# File Share Properties
variable "share_retention_days" {
  description = "Days to retain deleted file shares (7 days for FSLogix)"
  type        = number
  default     = 7
}

# Identity Configuration
variable "assign_identity" {
  description = "Assign managed identity for customer-managed keys"
  type        = bool
  default     = false
}

variable "identity_type" {
  description = "Type of managed identity (SystemAssigned or UserAssigned)"
  type        = string
  default     = "SystemAssigned"
}

variable "managed_identity_ids" {
  description = "List of User Assigned Managed Identity IDs"
  type        = list(string)
  default     = []
}

# Private Endpoint Configuration
variable "enable_private_endpoint" {
  description = "Enable private endpoint creation"
  type        = bool
  default     = true
}

variable "private_endpoint_subnet_id" {
  description = "Subnet ID for private endpoint"
  type        = string
  default     = null
}

variable "private_dns_zone_ids" {
  description = "List of Private DNS zone IDs for private endpoint"
  type        = list(string)
  default     = []
}

variable "private_endpoint_files_name" {
  description = "Name suffix for files private endpoint"
  type        = string
  default     = "files"
}

variable "private_endpoint_files_connection_name" {
  description = "Private service connection name for files"
  type        = string
  default     = "files"
}

variable "private_endpoint_files_subresource_name" {
  description = "Subresource name for files (file)"
  type        = string
  default     = "file"
}

variable "private_endpoint_is_manual_connection" {
  description = "Manual connection for private endpoint"
  type        = bool
  default     = false
}

variable "private_dns_zone_group_name" {
  description = "Name of the private DNS zone group"
  type        = string
  default     = "files"
}

# FSLogix File Share Configuration
variable "create_fslogix_share" {
  description = "Create FSLogix file share"
  type        = bool
  default     = true
}

variable "fslogix_share_name" {
  description = "Name of the FSLogix file share"
  type        = string
  default     = "fslogix"
}

variable "fslogix_quota_gb" {
  description = "Quota in GB for FSLogix share (minimum 100 GB for Premium)"
  type        = number
  default     = 128
}

variable "fslogix_protocol" {
  description = "Protocol for FSLogix share (SMB)"
  type        = string
  default     = "SMB"
}

// variable "fslogix_access_tier" {
//   description = "Access tier for FSLogix share (Hot for Premium)"
//   type        = string
//   default     = "Hot"
// }

variable "fslogix_metadata" {
  description = "Additional metadata for FSLogix share"
  type        = map(string)
  default     = {}
}

variable "fslogix_purpose" {
  description = "Purpose metadata for FSLogix share"
  type        = string
  default     = "fslogix"
}

# Role Assignments
variable "fslogix_principal_ids" {
  description = "List of principal IDs to grant FSLogix access"
  type        = list(string)
  default     = []
}

variable "fslogix_role_definition_name" {
  description = "Role definition name for FSLogix access"
  type        = string
  default     = "Storage File Data SMB Share Contributor"
}