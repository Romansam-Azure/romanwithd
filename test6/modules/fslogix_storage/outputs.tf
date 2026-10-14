# Storage Account
output "storage_account_id" {
  description = "The ID of the storage account"
  value       = azurerm_storage_account.fslogix.id
}

output "storage_account_name" {
  description = "The name of the storage account"
  value       = azurerm_storage_account.fslogix.name
}

output "primary_file_share_endpoint" {
  description = "The primary endpoint for the file service"
  value       = azurerm_storage_account.fslogix.primary_file_share_endpoint
}

output "storage_account_keys" {
  description = "The access keys for the storage account"
  value       = azurerm_storage_account.fslogix.primary_access_key
  sensitive   = true
}

# File Share
output "file_share_id" {
  description = "The ID of the FSLogix file share"
  value       = azurerm_storage_share.fslogix.id
}

output "file_share_name" {
  description = "The name of the FSLogix file share"
  value       = azurerm_storage_share.fslogix.name
}

output "file_share_url" {
  description = "The URL of the FSLogix file share"
  value       = "${azurerm_storage_account.fslogix.primary_file_share_endpoint}/${azurerm_storage_share.fslogix.name}"
}

# Private Endpoint
output "private_endpoint_id" {
  description = "The ID of the private endpoint"
  value       = var.enable_private_endpoint ? azurerm_private_endpoint.file_endpoint[0].id : null
}

output "private_endpoint_ip_address" {
  description = "The private IP address of the endpoint"
  value       = var.enable_private_endpoint ? azurerm_private_endpoint.file_endpoint[0].private_service_connection[0].private_ip_address : null
}

output "private_dns_a_record_id" {
  description = "The ID of the private DNS A record"
  value       = var.enable_private_endpoint && length(var.private_dns_zone_id) > 0 ? azurerm_private_dns_a_record.file_endpoint_dns[0].id : null
}

# Network
output "network_rules_id" {
  description = "The ID of the network rules"
  value       = azurerm_storage_account_network_rules.network_rules.id
}

# Role Assignment
output "role_assignment_id" {
  description = "The ID of the role assignment"
  value       = length(var.role_assignment_principal_id) > 0 ? azurerm_role_assignment.storage_file_data_smb_share_contributor[0].id : null
}

# Combined Outputs for Easy Use
output "fslogix_connection_string" {
  description = "Complete connection string for FSLogix (use with caution)"
  value       = "\\\\${azurerm_storage_account.fslogix.name}.file.core.windows.net\\${azurerm_storage_share.fslogix.name}"
}

output "fslogix_settings" {
  description = "Complete FSLogix configuration object"
  value = {
    storage_account_name = azurerm_storage_account.fslogix.name
    file_share_name      = azurerm_storage_share.fslogix.name
    storage_account_id   = azurerm_storage_account.fslogix.id
    file_share_url       = "${azurerm_storage_account.fslogix.primary_file_share_endpoint}/${azurerm_storage_share.fslogix.name}"
    private_ip_address   = var.enable_private_endpoint ? azurerm_private_endpoint.file_endpoint[0].private_service_connection[0].private_ip_address : null
    quota_in_gb          = var.quota_in_gb
  }
}