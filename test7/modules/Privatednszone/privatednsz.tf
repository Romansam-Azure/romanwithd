terraform {
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = "~>3.0"
      configuration_aliases = [azurerm]
    }
  }
}

resource "azurerm_private_dns_zone" "private_dns_zones" {
  for_each = toset(var.private_dns_zones)
  name = each.value
  resource_group_name  =var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "vnet_association" {
  for_each                 = azurerm_private_dns_zone.private_dns_zones
  name                     = format("%s-to-hub-vNet-link", var.virtual_network_name)
  resource_group_name      = var.resource_group_name
  private_dns_zone_name    = each.value.name
  virtual_network_id       = var.virtual_network_id # Assuming one vnet here
  registration_enabled     = var.registration_enabled
}


