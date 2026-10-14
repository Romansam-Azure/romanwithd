resource "azurerm_static_web_app" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku_size            = "Standard"
  sku_tier            = "Standard"
  tags                = var.tags
}