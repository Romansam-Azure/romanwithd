#Resource Group Deployment 

module "rgdeploy_hub" {
  source = "./modules/resourcegroupnew"
  resource_groups = var.hub_resource_groups
  location        = var.location
  tags            = var.tags
  
  providers = {
    azurerm = azurerm.shared
  }
}

// module "rgdeploy_mgt" {
//   source = "./modules/resourcegroupnew"
//   resource_groups = var.mgt_resource_groups
//   location        = var.location
//   tags            = var.tags
  
//   providers = {
//     azurerm = azurerm.mgmt
//   }
// }

module "hub-vnet" {
  source = "./modules/virtualnetworknew"

  virtual_network_name          = var.hub_vnet_name
  resource_group_name           = var.vnet_hub_rg_name
  location                      = var.location
  virtual_network_address_space = ["10.150.0.0/22"]
  dns_servers                   = var.dns_servers
  
  # Subnets are used in Index for other modules to refer
  # module.hub-vnet.vnet_subnet_id[0] = AzureBastionSubnet  
  # module.hub-vnet.vnet_subnet_id[1] = AzureFirewallSubnet          
  # module.hub-vnet.vnet_subnet_id[2] = GatewaySubnet       
  # module.hub-vnet.vnet_subnet_id[3] = snet-tes-rom-mgt-aue-01             
  # module.hub-vnet.vnet_subnet_id[4] = snet-tes-rom-pep-aue-01
  # module.hub-vnet.vnet_subnet_id[5] = snet-tes-rom-svs-aue-01      

  subnet_names = {
    "GatewaySubnet" = {
        subnet_name = "GatewaySubnet"
        address_prefixes = ["10.150.0.64/26"]
        service_endpoints = []
        delegation = []
    },
    "AzureFirewallSubnet" = {
        subnet_name = "AzureFirewallSubnet"
        address_prefixes = ["10.150.0.0/26"]
        service_endpoints = []
        delegation = []
    },
    "snet-tes-rom-pep-aue-01" = {
        subnet_name = "snet-tes-rom-pep-aue-01"
        address_prefixes = ["10.150.0.192/26"]
        service_endpoints = []
        delegation = []
       },
    "AzureBastionSubnet" = {
        subnet_name = "AzureBastionSubnet"
        address_prefixes = ["10.150.0.128/26"]
        service_endpoints = []
        delegation = []
    },
    "snet-tes-rom-svs-aue-01" = {
        subnet_name = "snet-tes-rom-svs-aue-01"
        address_prefixes = ["10.150.1.0/25"]
        service_endpoints = [ "Microsoft.KeyVault", "Microsoft.Storage", "Microsoft.AzureActiveDirectory", "Microsoft.EventHub", "Microsoft.Sql", "Microsoft.EventHub" ]
        delegation = []
    },
    "snet-tes-rom-mgt-aue-01" = {
        subnet_name = "snet-tes-rom-mgt-aue-01"
        address_prefixes = ["10.150.1.128/25"]
        service_endpoints = [ "Microsoft.KeyVault", "Microsoft.Storage", "Microsoft.AzureActiveDirectory", "Microsoft.EventHub", "Microsoft.Sql", "Microsoft.EventHub"  ]
        delegation         = [
             {
        name = "Microsoft.Network.dnsResolvers"
        service_delegation = {
          name    = "Microsoft.Network/dnsResolvers"
          actions = [
            "Microsoft.Network/virtualNetworks/subnets/join/action"
          ]
        }
        }
      ]
    }
  }
  providers = {
    azurerm = azurerm.shared
  }
  depends_on = [ module.rgdeploy_hub ]
}





#Private DNS Zone

module "private_dns_zones" {
  source = "./modules/Privatednszone"
  private_dns_zones  = var.private_dns_zones
  resource_group_name = var.vnet_hub_rg_name
  virtual_network_id = module.hub-vnet.vnet_id
  virtual_network_name = var.hub_vnet_name
  registration_enabled = var.registration_enabled
  
  providers = {
    azurerm = azurerm.shared
  }
  depends_on = [module.rgdeploy_hub, module.hub-vnet]
}



module "storage_account_hub_diag" {
  source = "./modules/storageaccountnew"
  providers = {
    azurerm = azurerm.shared
  }
  storageAccountName                   = var.hub_diag_StorageAccountName
  location                             = var.location
  envTag                               = var.StorageAccountTag
  saResourceGroup                      = var.hub_sto_rg
  account_tier                         = var.StorageAccountTier
  account_replication_type             = var.StorageAccountReplicationType
  allow_nested_items_to_be_public      = var.StorageAccountAllowPublic
  min_tls_version                      = var.StorageAccountTlsVersion
  infrastructure_encryption_enabled    = var.StorageAccountInfraEncryption
  is_hns_enabled                       = var.StorageAccountHns
  blob_soft_delete_retention_days      = var.StorageAccountBlobSoftDeleteDays
  sto_pep_nic_name   = var.sto_pep_nic_name
  storage_pep_name   = var.hub_stodiag_pep_name
  private_blob_dns_zone_ids = var.private_blob_dns_zone_ids
  subnet_id = module.hub-vnet.vnet_subnet_id[4]

  depends_on = [module.rgdeploy_hub, module.hub-vnet ]
}

module "storage_account_hub_boot" {
  source = "./modules/storageaccountnew"
  providers = {
    azurerm = azurerm.shared
  }
  storageAccountName                   = var.hub_boot_StorageAccountName
  location                             = var.location
  envTag                               = var.StorageAccountTag
  saResourceGroup                      = var.hub_sto_rg
  account_tier                         = var.StorageAccountTier
  account_replication_type             = var.StorageAccountReplicationType
  allow_nested_items_to_be_public      = var.StorageAccountAllowPublic
  min_tls_version                      = var.StorageAccountTlsVersion
  infrastructure_encryption_enabled    = var.StorageAccountInfraEncryption
  is_hns_enabled                       = var.StorageAccountHns
  blob_soft_delete_retention_days      = var.StorageAccountBlobSoftDeleteDays
  sto_pep_nic_name   = var.stoboot_pep_nic_name
  storage_pep_name   = var.hub_stoboot_pep_name
  private_blob_dns_zone_ids = var.private_blob_dns_zone_ids
  subnet_id = module.hub-vnet.vnet_subnet_id[4]

  depends_on = [module.rgdeploy_hub, module.hub-vnet ]
}

// module "storage_account_mgt_diag" {
//   source = "./modules/storageaccountnew/storemgmt"
//   providers = {
//     azurerm = azurerm.mgmt
//   }
//   storageAccountName                   = var.mgt_diag_StorageAccountName
//   location                             = var.location
//   envTag                               = var.StorageAccountTag
//   saResourceGroup                      = var.mgt_sto_rg
//   account_tier                         = var.StorageAccountTier
//   account_replication_type             = var.StorageAccountReplicationType
//   allow_nested_items_to_be_public      = var.StorageAccountAllowPublic
//   min_tls_version                      = var.StorageAccountTlsVersion
//   infrastructure_encryption_enabled    = var.StorageAccountInfraEncryption
//   is_hns_enabled                       = var.StorageAccountHns
//   blob_soft_delete_retention_days      = var.StorageAccountBlobSoftDeleteDays

//   depends_on = [module.rgdeploy_mgt ]
// }

// module "storage_account_mgt_nsg" {
//   source = "./modules/storageaccountnew/storemgmt"
//   providers = {
//     azurerm = azurerm.mgmt
//   }
//   storageAccountName                   = var.mgt_nsg_StorageAccountName
//   location                             = var.location
//   envTag                               = var.StorageAccountTag
//   saResourceGroup                      = var.mgt_sto_rg
//   account_tier                         = var.StorageAccountTier
//   account_replication_type             = var.StorageAccountReplicationType
//   allow_nested_items_to_be_public      = var.StorageAccountAllowPublic
//   min_tls_version                      = var.StorageAccountTlsVersion
//   infrastructure_encryption_enabled    = var.StorageAccountInfraEncryption
//   is_hns_enabled                       = var.StorageAccountHns
//   blob_soft_delete_retention_days      = var.StorageAccountBlobSoftDeleteDays

//   depends_on = [module.rgdeploy_mgt ]
// }

// module "storage_account_mgt_splunk" {
//   source = "./modules/storageaccountnew/storemgmt"
//   providers = {
//     azurerm = azurerm.mgmt
//   }
//   storageAccountName                   = var.mgt_splunk_StorageAccountName
//   location                             = var.location
//   envTag                               = var.StorageAccountTag
//   saResourceGroup                      = var.mgt_sto_rg
//   account_tier                         = var.StorageAccountTier
//   account_replication_type             = var.StorageAccountReplicationType
//   allow_nested_items_to_be_public      = var.StorageAccountAllowPublic
//   min_tls_version                      = var.StorageAccountTlsVersion
//   infrastructure_encryption_enabled    = var.StorageAccountInfraEncryption
//   is_hns_enabled                       = var.StorageAccountHns
//   blob_soft_delete_retention_days      = var.StorageAccountBlobSoftDeleteDays

//   depends_on = [module.rgdeploy_mgt ]
// }

// module "storage_account_mgt_cloud" {
//   source = "./modules/storageaccountnew/storemgmt"
//   providers = {
//     azurerm = azurerm.mgmt
//   }
//   storageAccountName                   = var.mgt_cloud_StorageAccountName
//   location                             = var.location
//   envTag                               = var.StorageAccountTag
//   saResourceGroup                      = var.mgt_sto_rg
//   account_tier                         = var.StorageAccountTier
//   account_replication_type             = var.StorageAccountReplicationType
//   allow_nested_items_to_be_public      = var.StorageAccountAllowPublic
//   min_tls_version                      = var.StorageAccountTlsVersion
//   infrastructure_encryption_enabled    = var.StorageAccountInfraEncryption
//   is_hns_enabled                       = var.StorageAccountHns
//   blob_soft_delete_retention_days      = var.StorageAccountBlobSoftDeleteDays

//   depends_on = [module.rgdeploy_mgt ]
// }

// module "storage_account_mgt_boot" {
//   source = "./modules/storageaccountnew/storemgmt"
//   providers = {
//     azurerm = azurerm.mgmt
//   }
//   storageAccountName                   = var.mgt_boot_StorageAccountName
//   location                             = var.location
//   envTag                               = var.StorageAccountTag
//   saResourceGroup                      = var.mgt_sto_rg
//   account_tier                         = var.StorageAccountTier
//   account_replication_type             = var.StorageAccountReplicationType
//   allow_nested_items_to_be_public      = var.StorageAccountAllowPublic
//   min_tls_version                      = var.StorageAccountTlsVersion
//   infrastructure_encryption_enabled    = var.StorageAccountInfraEncryption
//   is_hns_enabled                       = var.StorageAccountHns
//   blob_soft_delete_retention_days      = var.StorageAccountBlobSoftDeleteDays

//   depends_on = [module.rgdeploy_mgt ]
// }

// module "storage_account_mgt_ret" {
//   source = "./modules/storageaccountnew/storemgmt"
//   providers = {
//     azurerm = azurerm.mgmt
//   }
//   storageAccountName                   = var.mgt_retention_StorageAccountName
//   location                             = var.location
//   envTag                               = var.StorageAccountTag
//   saResourceGroup                      = var.mgt_sto_rg
//   account_tier                         = var.StorageAccountTier
//   account_replication_type             = var.StorageAccountReplicationType
//   allow_nested_items_to_be_public      = var.StorageAccountAllowPublic
//   min_tls_version                      = var.StorageAccountTlsVersion
//   infrastructure_encryption_enabled    = var.StorageAccountInfraEncryption
//   is_hns_enabled                       = var.StorageAccountHns
//   blob_soft_delete_retention_days      = var.StorageAccountBlobSoftDeleteDays

//   depends_on = [module.rgdeploy_mgt ]
// }

// module "vpn_gateway" {
//   source = "./modules/vpngateway"  # Path to the folder containing vpn_gateway.tf
//   vpn_gateway_name = var.vpn_gateway_name
//   location = var.location
//   resource_group_name = var.vnet_hub_rg_name
//   gateway_type = var.gateway_type
//   vpn_type = var.vpn_type
//   vpn_gw_sku = var.vpn_gw_sku
//   enable_active_active = var.enable_active_active
//   enable_bgp = var.enable_bgp
//   ip_configuration = var.ip_configuration
//   private_ip_address_allocation = "Dynamic"
//   subnet_id = module.hub-vnet.vnet_subnet_id[2]
//   public_ip_address_id = module.Public_vpn.public_ip_address_id
    
//   providers = {
//     azurerm = azurerm.shared
//   }
//    depends_on = [module.rgdeploy_hub, module.Public_vpn ]
// }


// module "defender" {
//   source = "./modules/defenderforcloud"
  
//   services = var.services
//   subscription_id = var.subscriptionMgmt
//   workspace_id = module.log_analytics.logAnalytics_id
//   resource_group_name      = var.log_analytics_rg_name
//   location        = var.location

//     providers = {
//     azurerm = azurerm.mgmt
//   }
//   depends_on = [module.log_analytics ]
// }


// module "defender_mgmt" {
//   source = "./modules/defenderforcloud"
  
//   services = var.services
//   subscription_id = var.subscriptionMgmt
//   workspace_id = module.log_analytics.logAnalytics_id
//   resource_group_name      = var.log_analytics_rg_name
//   location        = var.location

//     providers = {
//     azurerm = azurerm.mgmt
//   }
//   depends_on = [module.log_analytics ]
// }

// module "defender_hub" {
//   source = "./modules/defenderforcloud"
  
//   services = var.services
//   subscription_id = var.subscriptionShared
//   workspace_id = module.log_analytics.logAnalytics_id
//   resource_group_name      = var.log_analytics_rg_name
//   location        = var.location

//     providers = {
//     azurerm = azurerm.mgmt
//   }
//   depends_on = [module.log_analytics ]
// }

// module "defender_dmz" {
//   source = "./modules/defenderforcloud"
  
//   services = var.services
//   subscription_id = var.subscriptionProd
//   workspace_id = module.log_analytics.logAnalytics_id
//   resource_group_name      = var.log_analytics_rg_name
//   location        = var.location

//     providers = {
//     azurerm = azurerm.mgmt
//   }
//   depends_on = [module.log_analytics ]
// }
module "data_factory" {
  source = "./modules/datafactorynew"
  providers = {
    azurerm = azurerm.shared
  }
  data_factory_name                   = var.data_factory_name
  location                            = var.location
  resource_group_name                 = var.dfresource_group_name
  dataf_pep_nic_name                  = var.dataf_pep_nic_name
  dataf_pep_name                      = var.dataf_pep_name
  private_dataf_dns_zone_ids          = var.private_dataf_dns_zone_ids
  subnet_id                           = module.hub-vnet.vnet_subnet_id[4]

  depends_on = [module.rgdeploy_hub, module.hub-vnet ]
}

# Data sources for Key Vault and the secret
data "azurerm_key_vault" "keyvault" {
  name                = var.key_vault_name
  resource_group_name = var.key_vault_resource_group
}

data "azurerm_key_vault_secret" "sql_password" {
  name         = var.key_vault_secret_name
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

module "sql_server" {
  source = "./modules/sqlservernew"
  providers = {
    azurerm = azurerm.shared
  }
  sqlserver_name           = var.sqlserver_name
  location                 = var.location
  sqlResourceGroup         = var.sqlResourceGroup
  sql_username             = var.sql_username
  sql_password             = data.azurerm_key_vault_secret.sql_password.value
  sql_pep_nic_name         = var.sql_pep_nic_name
  sql_pep_name             = var.sql_pep_name
  private_sql_dns_zone_ids = var.private_sql_dns_zone_ids
  subnet_id                = module.hub-vnet.vnet_subnet_id[4]

  depends_on = [module.rgdeploy_hub, module.hub-vnet ]
}

module "Public_vpn" {
  source = "./modules/publicip"
  publicip_name            = var.publicip_vpn
  resource_group_name      = var.vnet_hub_rg_name
  location                 = var.location

  providers = {
    azurerm = azurerm.shared
  }
  depends_on = [module.rgdeploy_hub, module.hub-vnet ]
}

module "network_gateway" {
  source = "./modules/vpngateway"
  providers = {
    azurerm = azurerm.shared
  }

  # Pass variables from root module
  local_gateway_name               = var.local_gateway_name
  local_gateway_name2               = var.local_gateway_name2
  local_gateway_connection_name    = var.local_gateway_connection_name
  local_gateway_connection_name2    = var.local_gateway_connection_name2
  location                         = var.location
  resource_group_name              = var.vnet_hub_rg_name
  gateway_address                  = var.gateway_address
  gateway_address2                  = var.gateway_address2
  address_space                    = var.address_space
  address_space2                    = var.address_space2
  vpn_gateway_name                 = var.vpn_gateway_name
  gateway_type                     = var.gateway_type
  vpn_type                         = var.vpn_type
  vpn_gw_sku                       = var.vpn_gw_sku
  enable_active_active             = var.enable_active_active
  enable_bgp                       = var.enable_bgp
  ip_configuration                 = var.ip_configuration
  private_ip_address_allocation    = var.private_ip_address_allocation
  subnet_id                        = module.hub-vnet.vnet_subnet_id[2]
  public_ip_address_id             = module.Public_vpn.public_ip_address_id

  depends_on = [module.rgdeploy_hub, module.hub-vnet, module.Public_vpn ]
}

module "dns_resolver" {
  source = "./modules/dnsresolver"  # Update this path based on the location of your module

  dns_resolver_name     = var.dns_resolver_name
  resource_group_name   = var.vnet_hub_rg_name
  location              = var.location
  virtual_network_id    = module.hub-vnet.vnet_id
  inbound_endpoint_name = var.inbound_endpoint_name
  subnet_id             = module.hub-vnet.vnet_subnet_id[3]
}

#This log analyics spins up a workspace but still needs to be configured in the portal.

module "log_analytics" {
  source = "./modules/logAnalytics"

  log_analytics_rg_name =  var.log_analytics_rg_name
  log_analytics_name      = var.log_analytics_name
  log_analytics_location  = var.location
  providers = {
    azurerm = azurerm.shared
  }
  depends_on = [module.rgdeploy_hub]
}

#Recovery Service Vault 

module "recoversv_hub" {
 source = "./modules/recoveryservicevault"
  
  recovery_vault_name      = var.hub_recovery_vault_name
  resource_group_name      = var.rsv_hub_rg_name
  location                 = var.location
  sku                      = var.sku
  backup_policy_name       = var.backup_policy_name
  
    providers = {
    azurerm = azurerm.shared
  }
   depends_on = [module.rgdeploy_hub ]
}

// module "subscription_budget" {
//   source = "./modules/consumption"

//   budget_name          = var.budget_name
//   subscription_id      = var.subscription_id
//   amount               = var.amount
//   time_grain           = var.time_grain
//   start_date           = var.start_date
//   end_date             = var.end_date
//   resource_group_name  = var.mon_resourceGroup_name
//   contact_emails       = var.contact_emails
//   contact_roles        = var.contact_roles
//   notifications        = var.notifications
// }


module "mvc_policies" {
  source       = "./modules/policy/policyassignment"
  policy_scope = var.policy_scope
}

// module "tags_required" {
//   source       = "./modules/policy/TagsRequired"
//   policy_scope = var.policy_scope
// }

module "tag_policies" {
  source       = "./modules/policy/Tags"
  policy_scope = var.policy_scope
}


module "audit_vm" {
  source       = "./modules/policy/auditvm"
  policy_scope = var.policy_scope
}

module "publicip_network" {
  source       = "./modules/policy/publicip"
  policy_scope = var.policy_scope
}

module "storage_secure" {
  source       = "./modules/policy/storagehttps"
  policy_scope = var.policy_scope
}

// module "tag_required" {
//   source       = "./modules/policy/TagsRequired"
//   policy_scope = var.policy_scope

//   depends_on = [ module.tag_policies ]
// }

module "allow_sku" {
  source       = "./modules/policy/allowedsku"
  policy_scope = var.policy_scope
}


