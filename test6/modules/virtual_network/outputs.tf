output "vnet_ids" {
  description = "Map of virtual network names to their IDs"
  value       = { for k, vnet in azurerm_virtual_network.vnet : k => vnet.id }
}

output "vnet_names" {
  description = "Map of virtual network names to their names"
  value       = { for k, vnet in azurerm_virtual_network.vnet : k => vnet.name }
}

output "subnet_ids" {
  description = "Nested map of virtual network names to subnet names and their IDs"
  value = {
    for vnet_name, vnet in var.virtual_networks : vnet_name => {
      for subnet in vnet.subnets :
      subnet.name => (
        contains(keys(azurerm_subnet.subnet), "${vnet_name}.${subnet.name}") ?
        azurerm_subnet.subnet["${vnet_name}.${subnet.name}"].id :
        null
      )
    }
  }
}
