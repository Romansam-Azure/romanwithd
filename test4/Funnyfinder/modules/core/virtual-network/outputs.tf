output "vnet_id" {
  value = azurerm_virtual_network.this.id
}

output "pe_subnet_name" {
  value = azurerm_virtual_network.this.subnet[0].name
}

output "pe_subnet_id" {
  value = azurerm_virtual_network.this.subnet[0].id
}

output "app_subnet_name" {
  value = azurerm_virtual_network.this.subnet[1].name
}

output "app_subnet_id" {
  value = azurerm_virtual_network.this.subnet[1].id
}

output "key_vault_subnet_name" {
  value = azurerm_virtual_network.this.subnet[2].name
}

output "key_vault_subnet_id" {
  value = azurerm_virtual_network.this.subnet[2].id
}

output "storage_subnet_name" {
  value = azurerm_virtual_network.this.subnet[3].name
}

output "storage_subnet_id" {
  value = azurerm_virtual_network.this.subnet[3].id
}

output "postgresql_subnet_name" {
  value = azurerm_virtual_network.this.subnet[4].name
}

output "postgresql_subnet_id" {
  value = azurerm_virtual_network.this.subnet[4].id
}

output "apim_subnet_name" {
  value = azurerm_virtual_network.this.subnet[5].name
}

output "apim_subnet_id" {
  value = azurerm_virtual_network.this.subnet[5].id
}