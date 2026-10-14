# sitecore-xp-deployment/modules/oms/main.tf

resource "azurerm_log_analytics_workspace" "sitecore_oms" {
  name                = var.oms_workspace_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "PerGB2018"
}