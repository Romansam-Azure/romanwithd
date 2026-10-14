# FSLogix Storage Account
resource "azurerm_storage_account" "fslogix" {
  name                              = var.name
  resource_group_name               = var.resource_group_name
  location                          = var.location
  account_tier                      = "Premium"
  account_replication_type          = var.replication_type
  account_kind                      = "FileStorage"
  
  # Security Settings
  enable_https_traffic_only         = true
  min_tls_version                   = "TLS1_2"
  public_network_access_enabled     = false
  allow_nested_items_to_be_public   = false
  shared_access_key_enabled         = true
  default_to_oauth_authentication   = false
  infrastructure_encryption_enabled = var.enable_infrastructure_encryption
  
  # Tags
  tags = var.tags

  # Blob Properties (Soft Delete Disabled)
  blob_properties {
    delete_retention_policy {
      days = 0
    }
    container_delete_retention_policy {
      days = 0
    }
    versioning_enabled  = false
    change_feed_enabled = false
  }

  # File Share Properties (7-day retention)
  share_properties {
    retention_policy {
      days = 7
    }
  }
}

# Network Rules - Deny all except allowed subnets
resource "azurerm_storage_account_network_rules" "network_rules" {
  storage_account_id  = azurerm_storage_account.fslogix.id
  default_action      = "Deny"
  
  ip_rules             = var.ip_whitelist
  virtual_network_subnet_ids = var.allowed_subnets
}

# Private Endpoint for File Share
resource "azurerm_private_endpoint" "file_endpoint" {
  count               = var.enable_private_endpoint ? 1 : 0
  name                = "${var.name}-pe-files"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = "fslogix-files"
    private_connection_resource_id = azurerm_storage_account.fslogix.id
    is_manual_connection           = false
    subresource_names              = ["file"]
  }

  dynamic "private_dns_zone_group" {
    for_each = length(var.private_dns_zone_id) > 0 ? [1] : []
    content {
      name                 = "fslogix-files"
      private_dns_zone_ids = [var.private_dns_zone_id]
    }
  }

  tags = var.tags
}

# Private DNS A Record (if private endpoint enabled)
resource "azurerm_private_dns_a_record" "file_endpoint_dns" {
  count               = var.enable_private_endpoint && length(var.private_dns_zone_id) > 0 ? 1 : 0
  name                = var.name
  zone_name           = "privatelink.file.core.windows.net"
  resource_group_name = var.resource_group_name
  ttl                 = 300
  records             = [azurerm_private_endpoint.file_endpoint[0].private_service_connection[0].private_ip_address]

  tags = var.tags
}

# FSLogix File Share
resource "azurerm_storage_share" "fslogix" {
  name                 = var.file_share_name
  storage_account_name = azurerm_storage_account.fslogix.name
  quota_in_gb          = var.quota_in_gb

  enabled_protocol = "SMB"

  # Optional: NTFS ACL for Entra ID Kerberos (uncomment and configure as needed)
  # acl = jsonencode({
  #   "Default" = {
  #     "Id" = "S-1-5-21-...",  # Entra ID group SID
  #     "Permissions" = "rwdl"
  #   }
  # })

  depends_on = [azurerm_storage_account.fslogix]
}

# Optional: Role Assignment for AVD Session Hosts
resource "azurerm_role_assignment" "storage_file_data_smb_share_contributor" {
  count                = length(var.role_assignment_principal_id) > 0 ? 1 : 0
  scope                = azurerm_storage_account.fslogix.id
  role_definition_name = "Storage File Data SMB Share Contributor"
  principal_id         = var.role_assignment_principal_id

  depends_on = [azurerm_storage_account.fslogix]
}