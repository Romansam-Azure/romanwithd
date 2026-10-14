output "vpn_gateway_id" {
  description = "The resource ID of the virtual network gateway"
  value       = azurerm_virtual_network_gateway.vpngw.id
}

output "local_gateway_id" {
  description = "The resource ID of the local network gateway"
  value       = azurerm_local_network_gateway.onpremise.id
}

output "local_gateway2_id" {
  description = "The resource ID of the local network gateway"
  value       = azurerm_local_network_gateway.onpremise2.id
}