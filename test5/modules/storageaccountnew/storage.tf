terraform {
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = "~>3.0"
      configuration_aliases = [azurerm]
    }
  }
}


resource "azurerm_storage_account" "mvc_storage" {
  name                              = var.storageAccountName
  resource_group_name               = var.saResourceGroup
  location                          = var.location
  account_tier                      = var.account_tier
  account_replication_type          = var.account_replication_type
  allow_nested_items_to_be_public   = var.allow_nested_items_to_be_public
  min_tls_version                   = var.min_tls_version
  infrastructure_encryption_enabled = var.infrastructure_encryption_enabled
  is_hns_enabled                    = var.is_hns_enabled

  blob_properties {
    delete_retention_policy {
      days = var.blob_soft_delete_retention_days
    }
  }

  network_rules {
      default_action = "Deny"
  }

  tags = var.envTag
}

resource "azurerm_private_endpoint" "storage_pe" {
  name                = var.storage_pep_name
  location            = var.location
  resource_group_name = var.pep_resource_group_name
  custom_network_interface_name = var.sto_pep_nic_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "${var.storage_pep_name}-connection"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_storage_account.mvc_storage.id
    subresource_names              = ["blob"]
  }

  private_dns_zone_group {
    name                 = "privatelink.blob.core.windows.net"
    private_dns_zone_ids = var.private_blob_dns_zone_ids
  }
}