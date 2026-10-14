# sitecore-xp-deployment/modules/service_bus/main.tf

resource "azurerm_servicebus_namespace" "sitecore_asb" {
  name                = var.namespace_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku_name
  minimum_tls_version = var.min_tls_version
}

resource "azurerm_servicebus_queue" "sitecore_queues" {
  for_each     = toset(var.queues)
  name         = each.value
  namespace_id = azurerm_servicebus_namespace.sitecore_asb.id
}