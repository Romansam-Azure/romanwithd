# sitecore-xp-deployment/modules/sql/main.tf

resource "azurerm_mssql_server" "sitecore_sql" {
  name                         = var.sql_server_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = var.sql_server_version
  administrator_login          = var.sql_admin_username
  administrator_login_password = var.sql_admin_password
  minimum_tls_version          = "1.2"
}

resource "azurerm_mssql_database" "sitecore_dbs" {
  for_each            = var.databases
  name                = each.value.name
  server_id           = azurerm_mssql_server.sitecore_sql.id
  collation           = var.sql_database_collation
  sku_name            = "S0" # Adjust based on sitecore_sku
}

resource "azurerm_mssql_firewall_rule" "allow_all" {
  name                = "AllowAll"
  server_id           = azurerm_mssql_server.sitecore_sql.id
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "255.255.255.255"
}