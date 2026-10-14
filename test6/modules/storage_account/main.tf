# Storage Account for FSLogix
resource "azurerm_storage_account" "sa" {
  name                              = var.name
  location                          = var.location
  resource_group_name               = var.resource_group_name
  account_kind                      = var.account_kind
  account_tier                      = var.account_tier
  account_replication_type          = var.account_replication_type
  https_traffic_only_enabled         = var.enable_https_traffic_only
  min_tls_version                   = var.min_tls_version
  public_network_access_enabled     = var.public_network_access_enabled
  cross_tenant_replication_enabled  = var.cross_tenant_replication_enabled
  is_hns_enabled                    = var.is_hns_enabled
  nfsv3_enabled                     = var.nfsv3_enabled
  sftp_enabled                      = var.sftp_enabled
  default_to_oauth_authentication   = var.default_to_oauth_authentication
  shared_access_key_enabled         = var.shared_access_key_enabled
  allow_nested_items_to_be_public   = var.allow_nested_items_to_be_public
  tags                              = var.tags
  infrastructure_encryption_enabled = var.infrastructure_encryption_enabled

  // # Blob properties
  // blob_properties {
  //   dynamic "delete_retention_policy" {
  //     for_each = var.blob_delete_retention_days > 0 ? [1] : []
  //     content {
  //       days = var.blob_delete_retention_days
  //     }
  //   }
  //   dynamic "container_delete_retention_policy" {
  //     for_each = var.container_delete_retention_days > 0 ? [1] : []
  //     content {
  //       days = var.container_delete_retention_days
  //     }
  //   }
  //   versioning_enabled  = var.versioning_enabled
  //   change_feed_enabled = var.change_feed_enabled
  // }

  azure_files_authentication {
      directory_type                 = "AADKERB"
      default_share_level_permission = "StorageFileDataSmbShareContributor"

      active_directory {
          domain_guid         = "4fbb3d4e-12ec-48c7-a0a7-51bff2483bed"
          domain_name         = "ad.peoplefirstbank.com.au"
          domain_sid          = " "
          forest_name         = " "
          netbios_domain_name = " "
          storage_sid         = " "
        }
    }

    # File share properties
  dynamic "share_properties" {
    for_each = var.share_retention_days > 0 ? [1] : []
    content {
      smb {
        versions                        = []
        authentication_types            = []
        channel_encryption_type         = []
        kerberos_ticket_encryption_type = []
        multichannel_enabled            = true
      }

      retention_policy {
        days = var.share_retention_days
      }
    }
  }

  # Identity for customer-managed keys
  dynamic "identity" {
    for_each = var.assign_identity ? [1] : []
    content {
      type         = var.identity_type
      identity_ids = var.managed_identity_ids
    }
  }

}

# Private Endpoint for File Service
resource "azurerm_private_endpoint" "sa_files" {
  count               = var.enable_private_endpoint ? 1 : 0
  name                = "${var.name}-pe-${var.private_endpoint_files_name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = var.private_endpoint_files_connection_name
    private_connection_resource_id = azurerm_storage_account.sa.id
    is_manual_connection           = var.private_endpoint_is_manual_connection
    subresource_names              = [var.private_endpoint_files_subresource_name]
  }

  dynamic "private_dns_zone_group" {
    for_each = length(var.private_dns_zone_ids) > 0 ? [1] : []
    content {
      name                 = var.private_dns_zone_group_name
      private_dns_zone_ids = var.private_dns_zone_ids
    }
  }

  tags = var.tags
}

// # FSLogix File Share
// resource "azurerm_storage_share" "fslogix" {
//   count                 = var.create_fslogix_share ? 1 : 0
//   name                  = var.fslogix_share_name
//   storage_account_name  = azurerm_storage_account.sa.name
//   quota                 = var.fslogix_quota_gb
//   enabled_protocol      = var.fslogix_protocol

//   # Access tier for Premium billing
//   access_tier = var.fslogix_access_tier

//   # Metadata for FSLogix
//   metadata = merge(var.fslogix_metadata, {
//     purpose = var.fslogix_purpose
//   })

//   depends_on = [azurerm_storage_account.sa]
// }

resource "azurerm_storage_share" "fslogix" {
  count                = var.create_fslogix_share ? 1 : 0
  name                 = var.fslogix_share_name
  storage_account_name = azurerm_storage_account.sa.name
  quota                = var.fslogix_quota_gb

  # Only set if not empty
  enabled_protocol = var.fslogix_protocol

  metadata = merge(var.fslogix_metadata, {
    purpose = var.fslogix_purpose
  })

  depends_on = [
    azurerm_storage_account.sa,
    azurerm_private_endpoint.sa_files
  ]
}



# Optional: Role assignments for FSLogix access
resource "azurerm_role_assignment" "fslogix_access" {
  count                = var.create_fslogix_share && length(var.fslogix_principal_ids) > 0 ? length(var.fslogix_principal_ids) : 0
  scope                = azurerm_storage_account.sa.id
  role_definition_name = var.fslogix_role_definition_name
  principal_id         = var.fslogix_principal_ids[count.index]
}