terraform {
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = "~>3.0"
      configuration_aliases = [azurerm]
    }
  }
}

resource "azurerm_sql_server" "sql" {
  name                         = var.sqlserver_name
  resource_group_name          = var.sqlResourceGroup
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.sql_username
  administrator_login_password = var.sql_password

}

resource "azurerm_private_endpoint" "sql_pe" {
  name                = var.sql_pep_name
  location            = var.location
  resource_group_name = var.pep_resource_group_name
  custom_network_interface_name = var.sql_pep_nic_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "${var.sql_pep_name}-connection"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_sql_server.sql.id
    subresource_names              = ["sqlServer"]
  }

  private_dns_zone_group {
    name                 = "privatelink.database.windows.net"
    private_dns_zone_ids = var.private_sql_dns_zone_ids
  }
}