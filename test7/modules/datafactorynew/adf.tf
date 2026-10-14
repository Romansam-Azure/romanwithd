terraform {
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = "~>3.0"
      configuration_aliases = [azurerm]
    }
  }
}

resource "azurerm_data_factory" "adf" {
  name                = var.data_factory_name
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_endpoint" "dataf_pe" {
  name                = var.dataf_pep_name
  location            = var.location
  resource_group_name = var.pep_resource_group_name
  custom_network_interface_name = var.dataf_pep_nic_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "${var.dataf_pep_name}-connection"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_data_factory.adf.id
    subresource_names              = ["datafactory"]
  }

  private_dns_zone_group {
    name                 = "privatelink.datafactory.azure.net"
    private_dns_zone_ids = var.private_dataf_dns_zone_ids
  }
}