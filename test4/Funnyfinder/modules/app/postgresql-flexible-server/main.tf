# main.tf
resource "azurerm_postgresql_flexible_server" "this" {
  name                         = var.name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = var.version
  sku_name                     = var.sku_name
  administrator_login          = var.administrator_login
  administrator_password       = var.administrator_password
  zone                         = "1"
  storage_mb                   = 32768
  geo_redundant_backup_enabled = var.geo_redundant_backup
  high_availability {
    mode = var.high_availability
  }
  delegated_subnet_id = var.subnet_id
  private_dns_zone_id = var.private_dns_zone_id

  identity {
    type         = "UserAssigned"
    identity_ids = [var.user_assigned_identity_id]
  }
  tags = var.tags
}

resource "azurerm_postgresql_flexible_server_database" "db" {
  for_each  = toset(var.databases)
  name      = each.value
  server_id = azurerm_postgresql_flexible_server.this.id
  charset   = "UTF8"
  collation = "en_US.utf8"
}