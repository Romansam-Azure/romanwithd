# sitecore-xp-deployment/modules/redis/main.tf

resource "azurerm_redis_cache" "sitecore_redis" {
  name                = var.redis_cache_name
  resource_group_name = var.resource_group_name
  location            = var.location
  capacity            = var.sitecore_sku == "Extra Small" ? 0 : var.sitecore_sku == "Small" ? 1 : 2
  family              = "C"
  sku_name            = "Standard"
  enable_non_ssl_port = false
}