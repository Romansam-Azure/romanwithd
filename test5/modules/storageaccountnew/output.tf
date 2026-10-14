# Output variable definitions
output "primary_access_key" {
  description = "primary access key"
  value       = azurerm_storage_account.mvc_storage.primary_access_key
}

output "name" {
  description = "storage account name"
  value       = azurerm_storage_account.mvc_storage.name
}

output "id" {
  description = "storage account id"
  value       = azurerm_storage_account.mvc_storage.id
}