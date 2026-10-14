// # Look up Azure AD users by UPN
// data "azuread_user" "fslogix_users" {
//   for_each = toset([
//     "a-yshepetukhin@peoplefirstau.onmicrosoft.com",
//     "a-jarfah@peoplefirstau.onmicrosoft.com"
//   ])
//   user_principal_name = each.key
// }

// # Assign FSLogix SMB share contributor role at share level
// resource "azurerm_role_assignment" "fslogix_user_access" {
//   for_each = merge(
//     {
//       for k, v in data.azuread_user.fslogix_users :
//       "${k}-ae" => {
//         object_id = v.object_id
//         scope     = module.storage_ae.fslogix_share_id
//       }
//       if module.storage_ae.fslogix_share_id != null
//     },
//     {
//       for k, v in data.azuread_user.fslogix_users :
//       "${k}-ase" => {
//         object_id = v.object_id
//         scope     = module.storage_ase.fslogix_share_id
//       }
//       if module.storage_ase.fslogix_share_id != null
//     }
//   )

//   scope                = each.value.scope
//   role_definition_name = "Storage File Data SMB Share Contributor"
//   principal_id         = each.value.object_id
// }



module "storage_ae" {
  source = "./modules/storage_account"

  name                = "safslogixp01ae"
  location            = "australiaeast"
  resource_group_name = "rg-avd-p01-ae"
  tags = {
    "Object.Region"        = "ae"
    "Object.ResourceType"  = "sa"
    "Business.Application"     = "avd"
    "Business.EnvironmentType" = "prd"
    "Project.Code"             = "N.571.25.6795"
  }

  # Core settings (matching your requirements)
  account_tier                      = "Premium"
  account_kind                      = "FileStorage"
  account_replication_type          = "LRS"
  enable_https_traffic_only         = true
  min_tls_version                   = "TLS1_2"
  public_network_access_enabled     = false
  cross_tenant_replication_enabled  = false
  is_hns_enabled                    = false
  nfsv3_enabled                     = false
  sftp_enabled                      = false
  default_to_oauth_authentication   = false
  shared_access_key_enabled         = true
  allow_nested_items_to_be_public   = false
  infrastructure_encryption_enabled = false

  // # Blob settings (all disabled as per requirements)
  // versioning_enabled              = false
  // change_feed_enabled             = false
  // blob_delete_retention_days      = 0
  // container_delete_retention_days = 0

  # File share settings
  share_retention_days = 7

  # Private endpoint settings
  enable_private_endpoint         = true
  private_endpoint_subnet_id      = "/subscriptions/ee3f4544-7b5f-44f7-af75-2a4ca66cfeec/resourceGroups/rg-avd-networking-p01-ae/providers/Microsoft.Network/virtualNetworks/vnet-avd-p01-ae/subnets/snet-avd-endpoint-p01-ae"
  private_dns_zone_ids = [
    "/subscriptions/e2e6fc44-f2c5-498f-94c5-c4d271ed21ae/resourceGroups/rg-privatedns-p01-ae/providers/Microsoft.Network/privateDnsZones/privatelink.file.core.windows.net"
  ]

  # FSLogix settings
  create_fslogix_share = true
  fslogix_quota_gb     = 128
  fslogix_share_name   = "fslogix"
}


module "storage_ase" {
  source = "./modules/storage_account"

  name                = "safslogixp01ase"
  location            = "australiasoutheast"
  resource_group_name = "rg-avd-p01-ase"
  tags = {
    "Object.Region"        = "ase"
    "Object.ResourceType"  = "sa"
    "Business.Application"     = "avd"
    "Business.EnvironmentType" = "prd"
    "Project.Code"             = "N.571.25.6795"
  }

  # Core settings (matching your requirements)
  account_tier                      = "Premium"
  account_kind                      = "FileStorage"
  account_replication_type          = "LRS"
  enable_https_traffic_only         = true
  min_tls_version                   = "TLS1_2"
  public_network_access_enabled     = true
  cross_tenant_replication_enabled  = false
  is_hns_enabled                    = false
  nfsv3_enabled                     = false
  sftp_enabled                      = false
  default_to_oauth_authentication   = false
  shared_access_key_enabled         = true
  allow_nested_items_to_be_public   = false
  infrastructure_encryption_enabled = false

  // # Blob settings (all disabled as per requirements)
  // versioning_enabled              = false
  // change_feed_enabled             = false
  // blob_delete_retention_days      = 0
  // container_delete_retention_days = 0

  # File share settings
  share_retention_days = 7


  # Private endpoint settings
  enable_private_endpoint         = true
  private_endpoint_subnet_id      = "/subscriptions/ee3f4544-7b5f-44f7-af75-2a4ca66cfeec/resourceGroups/rg-avd-networking-p01-ase/providers/Microsoft.Network/virtualNetworks/vnet-avd-p01-ase/subnets/snet-avd-endpoint-p01-ase"
  private_dns_zone_ids = [
    "/subscriptions/e2e6fc44-f2c5-498f-94c5-c4d271ed21ae/resourceGroups/rg-privatedns-p01-ae/providers/Microsoft.Network/privateDnsZones/privatelink.file.core.windows.net"
  ]

  # FSLogix settings
  create_fslogix_share = true
  fslogix_quota_gb     = 128
  fslogix_share_name   = "fslogix"
}
