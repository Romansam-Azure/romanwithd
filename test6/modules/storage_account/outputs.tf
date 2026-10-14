output "storage_account_id" {
  description = "ID of the storage account"
  value       = azurerm_storage_account.sa.id
}

output "storage_account_name" {
  description = "Name of the storage account"
  value       = azurerm_storage_account.sa.name
}

// output "storage_account_primary_blob_endpoint" {
//   description = "Primary blob endpoint"
//   value       = azurerm_storage_account.sa.primary_blob_endpoint
// }

output "storage_account_primary_file_endpoint" {
  description = "Primary file endpoint"
  value       = azurerm_storage_account.sa.primary_file_endpoint
}

output "fslogix_share_id" {
  description = "ID of the FSLogix file share"
  value       = var.create_fslogix_share ? azurerm_storage_share.fslogix[0].id : null
}

output "fslogix_share_name" {
  description = "Name of the FSLogix file share"
  value       = var.create_fslogix_share ? azurerm_storage_share.fslogix[0].name : null
}

output "private_endpoint_id" {
  description = "ID of the private endpoint"
  value       = var.enable_private_endpoint ? azurerm_private_endpoint.sa_files[0].id : null
}

output "private_endpoint_fqdn" {
  value = var.enable_private_endpoint ? try(azurerm_private_endpoint.sa_files[0].custom_dns_configs[0].fqdn, null) : null
}