output "name" {
  value       = azurerm_private_endpoint.pe.name
  description = "Name of the created Private Endpoint"
}

output "id" {
  value       = azurerm_private_endpoint.pe.id
  description = "The ID of the Private Endpoint."
}

output "network_interface" {
  value       = azurerm_private_endpoint.pe.network_interface
  description = "A network_interface block."
}

output "private_dns_zone_group" {
  value       = azurerm_private_endpoint.pe.private_dns_zone_group
  description = "A private_dns_zone_group block."
}

output "custom_dns_configs" {
  value       = azurerm_private_endpoint.pe.custom_dns_configs
  description = "A custom_dns_configs block."
}

output "private_dns_zone_configs" {
  value       = azurerm_private_endpoint.pe.private_dns_zone_configs
  description = "A private_dns_zone_configs block."
}

output "private_service_connection" {
  value       = azurerm_private_endpoint.pe.private_service_connection
  description = "A private_service_connection block."
}
