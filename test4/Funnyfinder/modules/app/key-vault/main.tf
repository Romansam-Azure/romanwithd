# main.tf
resource "azurerm_key_vault" "this" {
  name                        = var.name
  resource_group_name         = var.resource_group_name
  location                    = var.location
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "standard"
  purge_protection_enabled    = true
  enable_rbac_authorization   = false
  tags                        = var.tags
}

resource "azurerm_key_vault_access_policy" "api_identity" {
  key_vault_id       = azurerm_key_vault.this.id
  tenant_id          = data.azurerm_client_config.current.tenant_id
  object_id          = var.identity_principal_id
  secret_permissions = ["Get", "List", "Set", "Delete"]
}

resource "azurerm_key_vault_access_policy" "function_identity" {
  key_vault_id       = azurerm_key_vault.this.id
  tenant_id          = data.azurerm_client_config.current.tenant_id
  object_id          = var.function_principal_id
  secret_permissions = ["Get", "List"]
}

resource "azurerm_key_vault_secret" "username" {
  name         = "postgresAdminUsername"
  value        = var.postgres_admin_username
  key_vault_id = azurerm_key_vault.this.id
}

resource "azurerm_key_vault_secret" "password" {
  name         = "postgresAdminPassword"
  value        = var.postgres_admin_password
  key_vault_id = azurerm_key_vault.this.id
}
