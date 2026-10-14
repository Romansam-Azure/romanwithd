data "azurerm_storage_account" "this" {
  name                = var.storage_account_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_role_assignment" "this" {
  scope                = data.azurerm_storage_account.this.id
  role_definition_id   = var.role_definition_id
  principal_id         = var.principal_id
}