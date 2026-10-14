resource "azurerm_storage_account" "this" {
  name                     = var.name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_kind             = "StorageV2"
  account_tier             = split("_", var.sku.name)[0]
  account_replication_type = split("_", var.sku.name)[1]
  min_tls_version          = "TLS1_2"
  allow_blob_public_access = false
  public_network_access    = var.public_network_access
  tags                     = var.tags

  dynamic "blob_properties" {
    for_each = var.containers
    content {
      container {
        name = blob_properties.value.name
      }
    }
  }
}