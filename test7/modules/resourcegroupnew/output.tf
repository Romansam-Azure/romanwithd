output "resource_group_location" {
  description = "The location of the Azure Resource Groups"
  value       = { for key, rg in azurerm_resource_group.rg : key => rg.location }
}

output "resource_group_name" {
  description = "The names of the Azure Resource Groups"
  value       = { for key, rg in azurerm_resource_group.rg : key => rg.name }
}

output "resource_rg_id" {
  description = "The IDs of the Azure Resource Groups"
  value       = { for key, rg in azurerm_resource_group.rg : key => rg.id }
}
