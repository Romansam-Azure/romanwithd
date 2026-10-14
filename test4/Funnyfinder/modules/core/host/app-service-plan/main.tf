resource "azurerm_service_plan" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku_name            = var.sku.name
  os_type             = "Linux"
  tags                = var.tags
}