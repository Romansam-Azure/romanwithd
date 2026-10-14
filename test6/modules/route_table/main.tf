# ./modules/route_table/main.tf
resource "azurerm_route_table" "route_table" {
  for_each                      = var.route_tables
  name                          = each.key
  location                      = var.location
  resource_group_name           = var.resource_group_name
  bgp_route_propagation_enabled = false
  tags = merge(
    var.common_tags,
    { "Object.ResourceType" = "udr" }
  )

  dynamic "route" {
    for_each = each.value.routes
    content {
      name                   = route.value.name
      address_prefix         = route.value.address_prefix
      next_hop_type          = route.value.next_hop_type

      # Only set next_hop_in_ip_address when it is provided
      next_hop_in_ip_address = try(route.value.next_hop_in_ip_address, null)
    }
  }
}