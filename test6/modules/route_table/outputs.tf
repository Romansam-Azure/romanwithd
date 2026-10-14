output "route_table_ids" {
  value = { for k, v in azurerm_route_table.route_table : k => v.id }
}