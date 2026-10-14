# modules/upload_packages/main.tf

resource "azurerm_storage_account" "sitecore" {
  name                     = "stsitecore${random_string.rand.result}"
  location                 = var.location
  resource_group_name      = var.resource_group_name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "packages" {
  name                  = "packages"
  storage_account_name  = azurerm_storage_account.sitecore.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "wdps" {
  for_each               = fileset(var.package_folder, "*.zip")
  name                   = each.value
  source                 = "${var.package_folder}/${each.value}"
  storage_account_name   = azurerm_storage_account.sitecore.name
  storage_container_name = azurerm_storage_container.packages.name
  type                   = "Block"
}

resource "azurerm_storage_account_sas" "sas" {
  connection_string = azurerm_storage_account.sitecore.primary_connection_string

  https_only     = true
  start          = "2024-01-01"
  expiry         = "2030-01-01"
  resource_types = ["o"]
  services       = ["b"]
  permissions    = ["r", "l"]

  content {
    signed_resource   = "c"
    signed_permission = "rl"
    signed_service    = "b"
    signed_expiry     = "2030-01-01T00:00Z"
  }
}

resource "random_string" "rand" {
  length  = 6
  upper   = false
  special = false
}

# modules/upload_packages/variables.tf

variable "resource_group_name" {}
variable "location" {}
variable "package_folder" {}

# modules/upload_packages/outputs.tf

output "sas_token" {
  value = azurerm_storage_account_sas.sas.sas
}

output "package_urls" {
  value = {
    for f in fileset(var.package_folder, "*.zip") :
    trimsuffix(f, ".zip") => "https://${azurerm_storage_account.sitecore.name}.blob.core.windows.net/${azurerm_storage_container.packages.name}/${f}${azurerm_storage_account_sas.sas.sas}"
  }
}
