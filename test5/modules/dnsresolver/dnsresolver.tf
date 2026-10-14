terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

resource "azurerm_private_dns_resolver" "resolver" {
  name                = var.dns_resolver_name
  resource_group_name = var.resource_group_name
  location            = var.location
  virtual_network_id  = var.virtual_network_id
}

resource "azurerm_private_dns_resolver_inbound_endpoint" "example" {
  name                    = var.inbound_endpoint_name
  private_dns_resolver_id = azurerm_private_dns_resolver.resolver.id
  location                = var.location
  ip_configurations {
    private_ip_allocation_method = "Dynamic"
    subnet_id                    = var.subnet_id
  }
}