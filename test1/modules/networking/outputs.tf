output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "private_endpoint_subnet_id" {
  value = azurerm_subnet.private_endpoints.id
}

output "app_service_subnet_id" {
  value = azurerm_subnet.app_service.id
}

output "private_dns_zone_ids" {
  value = {
    postgres = data.azurerm_private_dns_zone.postgres.id
    vault    = data.azurerm_private_dns_zone.vault.id
    blob     = data.azurerm_private_dns_zone.blob.id
    monitor  = data.azurerm_private_dns_zone.monitor.id
  }
}