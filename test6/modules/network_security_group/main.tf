resource "azurerm_network_security_group" "nsg" {
  for_each            = var.network_security_groups
  name                = each.key
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = merge(var.common_tags, { "Object.ResourceType" = "nsg" })

  dynamic "security_rule" {
    for_each = each.value.rules
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                   = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = try(security_rule.value.destination_port_range, null)
      destination_port_ranges    = try(security_rule.value.destination_port_ranges, [])
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }
}
