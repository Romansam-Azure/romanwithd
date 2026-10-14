terraform {
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = "~>3.0"
      configuration_aliases = [azurerm]
    }
  }
}

resource "azurerm_resource_group" "rg" {
  for_each    = var.resource_groups

    name      = each.key
    location  = var.location
    tags      = var.tags
}