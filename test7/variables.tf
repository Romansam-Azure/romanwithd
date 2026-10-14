#Enter in your subscription IDs from the Azure tenant here.
#Production Subscription

variable "bkstrgrg" {
  type        = string
  description = "The name of the backend storage account resource group"
  default     = "<storage act resource group name>"
}

variable "bkstrg" {
  type        = string
  description = "The name of the backend storage account"
  default     = "<storage account name>"
}

variable "bkcontainer" {
  type = string
  description = "The container name for the backend config"
  default = "<blob storage container name>"
}

#Shared Subscription
variable "subscriptionShared" {
  description = "Name for Shared to add to Management Group"
}


#Set the default location for resources here ----------------------------------
variable "location" {
  description = "Name for location"
}
#Location end--------------------------------------------------------------------



variable "tags" {
  type        = map(any)
  description = "(Optional) A map of tags to be applied globally on all Azure resources"
  default     = {}
}

variable "hub_resource_groups" {
  type        = map(any)
  description = "(Required) A list of Azure Resource Groups with locations and tags"
  default     = {}
}


// variable "mgt_resource_groups" {
//   type        = map(any)
//   description = "(Required) A list of Azure Resource Groups with locations and tags"
//   default     = {}
// }


variable "log_analytics_name" {
  description = "log analytics name"
}

variable "log_analytics_rg_name" {
  description = "log resource group  name"
}

#Automation account Variable

// variable "aac_rg_name" {
//   description = "A container that holds related resources for an Azure solution"
// }

// variable "mgt_automation_account_name" {
//   description = "Specifies the name of the Automation Account"
// }

// variable "sku_name" {
//   description = "The SKU name of the account - only Basic is supported at this time"
//   default     = "Basic"
// }

// variable "mgt2_automation_account_name" {
//   description = "Specifies the name of the Automation Account"
// }

// variable "auto_diag_logs" {
//   description = "A list of categories of platform logs and/or metrics that you want to collect from a resource"
//   default     = ["AuditEvent" , "DscNodeStatus"]
// }

// variable "log_analytics_workspace_id" {
//   description = "The name of log analytics workspace id"
//   default     = null
// }

// variable "aac_hub_rg_name" {
//   description = "A container that holds related resources for an Azure solution"
// }

// variable "hub_automation_account_name" {
//   description = "Specifies the name of the Automation Account"
// }




#Recovery Service Vault Variables


variable "hub_recovery_vault_name" {
  type = string
  default = "rsv-rom-hub-prd-bkp-aue-01"
}



variable "sku" {
  type = string
  default = "Standard"
}

variable "backup_policy_name" {
  type = string
  default = "my-backup-policy"
}

variable "rsv_hub_rg_name" {
  description = "A container that holds related resources for an Azure solution"
}


variable "vnet_hub_rg_name" {
  description = "A container that holds related resources for an Azure solution"
}

variable "hub_vnet_name" {
  description = "A container that holds related resources for an Azure solution"
}

variable "dns_servers" {
  description = "Ip address of the dns servers"
}

variable "source_address_prefixes" {
  type        = list(string)
  default     = null
  description = "Destination address prefix to be applied to all predefined rules"
}

variable "destination_address_prefixes" {
  type        = list(string)
  default     = null
  description = "Destination address prefix to be applied to all predefined rules"
}

// variable "hub_bsub_security_group_name" {
//   description = "Network security group name"
// }

#variable "subnet_names" {
#  description = "A list of public subnets inside the vNet."
#}

// variable "bastion_sub_rules" {
//   description = "Provide a map of pre-defined rules, see pre_defined_rules.tf for available rules"
// }

// variable "hub_svs_security_group_name" {
//   description = "Network security group name"
// }

#variable "subnet_names" {
#  description = "A list of public subnets inside the vNet."
#}

// variable "hub_svs_rules" {
//   description = "Provide a map of pre-defined rules, see pre_defined_rules.tf for available rules"
// }

# variables.tf

// variable "hub_gw_routes" {
//   description = "Map of routes to add to the route table. Multiple routes can be defined with multiple maps."
//   type        = map(object({
//     route_name             = string
//     address_prefix         = string
//     next_hop_type          = string
//     next_hop_in_ip_address = string
//   }))
//   default = {
//     "to-vnet-ilr-shd-prd-aue-01" = {
//       route_name             = "to-vnet-ilr-shd-prd-aue-01",
//       address_prefix         = "10.155.0.0/22",
//       next_hop_type          = "VirtualAppliance",
//       next_hop_in_ip_address = "10.140.0.4"
//     }
//     "to-vnet-ilr-shd-stg-aue-01" = {
//       route_name             = "to-vnet-ilr-shd-stg-aue-01",
//       address_prefix         = "172.16.0.0/16",
//       next_hop_type          = "VirtualAppliance",
//       next_hop_in_ip_address = "10.140.0.4"
//     }
//     "to-vnet-ilr-shd-dev-aue-01" = {
//       route_name             = "to-vnet-ilr-shd-dev-aue-01",
//       address_prefix         = "10.165.0.0/22",
//       next_hop_type          = "VirtualAppliance",
//       next_hop_in_ip_address = "10.140.0.4"
//     }
//     "to-vnet-dta-shd-prd-aue-01" = {
//       route_name             = "to-vnet-dta-shd-prd-aue-01",
//       address_prefix         = "10.170.0.0/22",
//       next_hop_type          = "VirtualAppliance",
//       next_hop_in_ip_address = "10.140.0.4"
//     }
//     "to-vnet-dta-shd-stg-aue-01" = {
//       route_name             = "to-vnet-dta-shd-stg-aue-01",
//       address_prefix         = "10.175.0.0/22",
//       next_hop_type          = "VirtualAppliance",
//       next_hop_in_ip_address = "10.140.0.4"
//     }
//     "to-vnet-dta-shd-dev-aue-01" = {
//       route_name             = "to-vnet-dta-shd-dev-aue-01",
//       address_prefix         = "10.180.0.0/22",
//       next_hop_type          = "VirtualAppliance",
//       next_hop_in_ip_address = "10.140.0.4"
//     }
//     "to-p2s-vpn-subnet" = {
//       route_name             = "to-p2s-vpn-subnet",
//       address_prefix         = "172.16.100.0/23",
//       next_hop_type          = "VirtualAppliance",
//       next_hop_in_ip_address = "10.140.0.4"
//     }
//     "to-hub-shd-prd-mgt-subnet" = {
//       route_name             = "to-hub-shd-prd-mgt-subnet",
//       address_prefix         = "10.140.1.128/25",
//       next_hop_type          = "VirtualAppliance",
//       next_hop_in_ip_address = "10.140.0.4"
//     }
//     "to-hub-shd-prd-svs-subnet" = {
//       route_name             = "to-hub-shd-prd-svs-subnet",
//       address_prefix         = "10.140.1.0/25",
//       next_hop_type          = "VirtualAppliance",
//       next_hop_in_ip_address = "10.140.0.4"
//     }
//   }
// }


// variable "hub_fw_routes" {
//   description = "Map of routes to add to the route table. Multiple routes can be defined with multiple maps."
//   type        = map(object({
//     route_name             = string
//     address_prefix         = string
//     next_hop_type          = string
//     next_hop_in_ip_address = string
//   }))
//   default = {
//     "default" = {
//       route_name             = "default",
//       address_prefix         = "0.0.0.0/0",
//       next_hop_type          = "Internet",
//       next_hop_in_ip_address = null
//     }
//   }
// }

// variable "hub_svs_routes" {
//   description = "Map of routes to add to the route table. Multiple routes can be defined with multiple maps."
//   type        = map(object({
//     route_name             = string
//     address_prefix         = string
//     next_hop_type          = string
//     next_hop_in_ip_address = string
//   }))
//   default = {
//     "default" = {
//       route_name             = "default",
//       address_prefix         = "0.0.0.0/0",
//       next_hop_type          = "VirtualAppliance",
//       next_hop_in_ip_address = "10.140.0.4"
//     }
//     "to-vnet-ilr-shd-prd-aue-01" = {
//       route_name             = "to-vnet-ilr-shd-prd-aue-01",
//       address_prefix         = "10.155.0.0/22",
//       next_hop_type          = "VirtualAppliance",
//       next_hop_in_ip_address = "10.140.0.4"
//     }
//     "to-vnet-ilr-shd-stg-aue-01" = {
//       route_name             = "to-vnet-ilr-shd-stg-aue-01",
//       address_prefix         = "172.16.0.0/16",
//       next_hop_type          = "VirtualAppliance",
//       next_hop_in_ip_address = "10.140.0.4"
//     }
//     "to-vnet-ilr-shd-dev-aue-01" = {
//       route_name             = "to-vnet-ilr-shd-dev-aue-01",
//       address_prefix         = "10.165.0.0/22",
//       next_hop_type          = "VirtualAppliance",
//       next_hop_in_ip_address = "10.140.0.4"
//     }
//     "to-vnet-dta-shd-prd-aue-01" = {
//       route_name             = "to-vnet-dta-shd-prd-aue-01",
//       address_prefix         = "10.170.0.0/22",
//       next_hop_type          = "VirtualAppliance",
//       next_hop_in_ip_address = "10.140.0.4"
//     }
//     "to-vnet-dta-shd-stg-aue-01" = {
//       route_name             = "to-vnet-dta-shd-stg-aue-01",
//       address_prefix         = "10.175.0.0/22",
//       next_hop_type          = "VirtualAppliance",
//       next_hop_in_ip_address = "10.140.0.4"
//     }
//     "to-vnet-dta-shd-dev-aue-01" = {
//       route_name             = "to-vnet-dta-shd-dev-aue-01",
//       address_prefix         = "10.180.0.0/22",
//       next_hop_type          = "VirtualAppliance",
//       next_hop_in_ip_address = "10.140.0.4"
//     }
//     "to-p2s-vpn-subnet" = {
//       route_name             = "to-p2s-vpn-subnet",
//       address_prefix         = "172.16.100.0/23",
//       next_hop_type          = "VirtualAppliance",
//       next_hop_in_ip_address = "10.140.0.4"
//     }
//     "to-hub-shd-prd-mgt-subnet" = {
//       route_name             = "to-hub-shd-prd-mgt-subnet",
//       address_prefix         = "10.140.1.128/25",
//       next_hop_type          = "VirtualNetworkGateway",
//       next_hop_in_ip_address = null
//     }
//   }
// }

// variable "hub_mgt_routes" {
//   description = "Map of routes to add to the route table. Multiple routes can be defined with multiple maps."
//   type        = map(object({
//     route_name             = string
//     address_prefix         = string
//     next_hop_type          = string
//     next_hop_in_ip_address = string
//   }))
//   default = {
//     "default" = {
//       route_name             = "default",
//       address_prefix         = "0.0.0.0/0",
//       next_hop_type          = "VirtualAppliance",
//       next_hop_in_ip_address = "10.140.0.4"
//     }
//     "to-vnet-ilr-shd-prd-aue-01" = {
//       route_name             = "to-vnet-ilr-shd-prd-aue-01",
//       address_prefix         = "10.155.0.0/22",
//       next_hop_type          = "VirtualAppliance",
//       next_hop_in_ip_address = "10.140.0.4"
//     }
//     "to-vnet-ilr-shd-stg-aue-01" = {
//       route_name             = "to-vnet-ilr-shd-stg-aue-01",
//       address_prefix         = "172.16.0.0/16",
//       next_hop_type          = "VirtualAppliance",
//       next_hop_in_ip_address = "10.140.0.4"
//     }
//     "to-vnet-ilr-shd-dev-aue-01" = {
//       route_name             = "to-vnet-ilr-shd-dev-aue-01",
//       address_prefix         = "10.165.0.0/22",
//       next_hop_type          = "VirtualAppliance",
//       next_hop_in_ip_address = "10.140.0.4"
//     }
//     "to-vnet-dta-shd-prd-aue-01" = {
//       route_name             = "to-vnet-dta-shd-prd-aue-01",
//       address_prefix         = "10.170.0.0/22",
//       next_hop_type          = "VirtualAppliance",
//       next_hop_in_ip_address = "10.140.0.4"
//     }
//     "to-vnet-dta-shd-stg-aue-01" = {
//       route_name             = "to-vnet-dta-shd-stg-aue-01",
//       address_prefix         = "10.175.0.0/22",
//       next_hop_type          = "VirtualAppliance",
//       next_hop_in_ip_address = "10.140.0.4"
//     }
//     "to-vnet-dta-shd-dev-aue-01" = {
//       route_name             = "to-vnet-dta-shd-dev-aue-01",
//       address_prefix         = "10.180.0.0/22",
//       next_hop_type          = "VirtualAppliance",
//       next_hop_in_ip_address = "10.140.0.4"
//     }
//     "to-p2s-vpn-subnet" = {
//       route_name             = "to-p2s-vpn-subnet",
//       address_prefix         = "172.16.100.0/23",
//       next_hop_type          = "VirtualAppliance",
//       next_hop_in_ip_address = "10.140.0.4"
//     }
//     "to-hub-shd-prd-svs-subnet" = {
//       route_name             = "to-hub-shd-prd-svs-subnet",
//       address_prefix         = "10.140.1.0/25",
//       next_hop_type          = "VirtualNetworkGateway",
//       next_hop_in_ip_address = null
//     }
//   }
// }

// variable "hub_gw_route_table_name" {
//   type        = string
//   default     = null
// }

// variable "hub_fw_route_table_name" {
//   type        = string
//   default     = null
// }

// variable "hub_svs_route_table_name" {
//   type        = string
//   default     = null
// }


// variable "hub_mgt_route_table_name" {
//   type        = string
//   default     = null
// }


// variable "azure_firewall_policy_name" {
//   description = "The full Azure resource ID of the remote virtual network."
//   default = "policy_name_firewall"
// }

// variable "public_ip_address_id" {
//   description = "The full Azure resource ID of the remote virtual network."
//   default = null
// }

// variable "public_ip_address" {
//   description = "The full Azure resource ID of the remote virtual network."
//   default = null
// }

// variable "publicip_af" {
//   type = string
//   default = "azure_firewall_pip"
// }

// variable "publicip_vpn" {
//   type = string
//   default = "vpn_gateway_pip"
// }

variable "vnet_id" {
  description = "The full Azure resource ID of the remote virtual network."
  default = null
}

variable "subnet_id" {
  description = "The full Azure resource ID of the remote virtual network."
  default = null
}

// variable "hub_kv_name" {
//   description = "Keyvault for MVC"
// }

// variable "hub_kv_rg" {
//   description = "Keyvault rg"
// }

// variable "hub_kv_pep_name" {
//   description = "keyvault name"
// }

// variable "private_vault_dns_zone_ids" {
//   description = "keyvault name"
// }

variable "private_dns_zones" {
  type    = list(string)
  default = ["privatelink.blob.core.windows.net", 
             "privatelink.database.windows.net",
             "privatelink.file.core.windows.net",
             "privatelink.vaultcore.azure.net",
             "privatelink.sql.azuresynapse.net",
             "privatelink.dev.azuresynapse.net",
             "privatelink.azurewebsites.net",
             "scm.privatelink.azurewebsites.net",
             "privatelink.datafactory.azure.net",
             "privatelink.adf.azure.com"]
}

variable "registration_enabled" {
  description = "True or False."
  default     = false
}

#Storage Account Vars --------------------
variable "hub_diag_StorageAccountName" {
  description = "log analytics name"
}

variable "hub_boot_StorageAccountName" {
  description = "log analytics name"
}

// variable "mgt_diag_StorageAccountName" {
//   description = "log analytics name"
// }

// variable "mgt_nsg_StorageAccountName" {
//   description = "log analytics name"
// }

// variable "mgt_splunk_StorageAccountName" {
//   description = "log analytics name"
// }

// variable "mgt_cloud_StorageAccountName" {
//   description = "log analytics name"
// }

// variable "mgt_boot_StorageAccountName" {
//   description = "log analytics name"
// }

// variable "mgt_retention_StorageAccountName" {
//   description = "log analytics name"
// }

variable "private_blob_dns_zone_ids" {
  description = "Storage Pep id"
}

variable "hub_stodiag_pep_name" {
  description = "keyvault name"
}

variable "hub_stoboot_pep_name" {
  description = "keyvault name"
}

variable "hub_sto_rg" {
  description = "rg name"
}

variable "StorageAccountTag" {
  description = "log analytics Storage Account Tag"
}
variable "StorageAccountTier" {
  description = "log analytics Storage Account Tier"
}
variable "StorageAccountReplicationType" {
  description = "log analytics Storage Account Replication Type"
}
variable "StorageAccountAllowPublic" {
  description = "log analytics Storage Account Allow Public"
}
variable "StorageAccountTlsVersion" {
  description = "log analytics Storage Account Tls Version"
}
variable "StorageAccountBlobSoftDeleteDays" {
  description = "log analytics Storage Account Blob Soft Delete Days"
}
# Container Name
# If account_tier is Premium use true
variable "StorageAccountInfraEncryption" {
  description = "log analytics Storage Account Infra Encryption"
}
variable "StorageAccountHns" {
  description = "log analytics Storage Account Hns"
}

variable "sto_pep_nic_name" {
  description = "storage pep nic name"
}

variable "stoboot_pep_nic_name" {
  description = "storage pep nic name"
}

variable "data_factory_name" {
  description = "The name of the Data Factory"
}


variable "dfresource_group_name" {
  description = "The name of the resource group"
}

variable "sqlResourceGroup" {
  description = "resource group name"
}

variable "sqlserver_name" {
  description = "storage account name"
}

variable "sql_username" {
  description = "storage account name"
}

variable "key_vault_name" {
  description = "The name of the Key Vault"
}

variable "key_vault_resource_group" {
  description = "The name of the Resource Group where the Key Vault is located"
}

variable "key_vault_secret_name" {
  description = "The name of the secret in Key Vault"
}


variable "private_sql_dns_zone_ids" {
  description = "sql Pep id"
}

variable "private_dataf_dns_zone_ids" {
  description = "datafactory Pep id"
}

variable "sql_pep_name" {
  description = "sql pep name"
}

variable "dataf_pep_name" {
  description = "datafactory pep name"
}

variable "sql_pep_nic_name" {
  description = "sql pep nic name"
}

variable "dataf_pep_nic_name" {
  description = "datafactory pep nic name"
}

# Public ip 

variable "public_ip_address_id" {
  description = "The full Azure resource ID of the remote virtual network."
  default = null
}

variable "publicip_vpn" {
  type = string
  default = "vpn_gateway_pip"
}


#VPN gateway Variables

variable "local_gateway_connection_name" {
  description = "The name of the Virtual Network Gateway connection to the local network"
  type        = string
}

variable "local_gateway_connection_name2" {
  description = "The name of the Virtual Network Gateway connection to the local network"
  type        = string
}


variable "vpn_gw_sku" {
  description = "The SKU of the Public IP. Accepted values are Basic and Standard. Defaults to Basic"
  type        = string
  default     = "VpnGw1"
}

variable "local_gateway_name" {
  description = "The name of the Local Network Gateway."
  type        = string
  default     = "lgw-tes-rom-prd-aue-01"
}

variable "local_gateway_name2" {
  description = "The name of the Local Network Gateway."
  type        = string
  default     = "lgw-tes-rom-prd-aue-02"
}

variable "vpn_gateway_name" {
  description = "The name of the vpn_gateway_name"
  type        = string
  default     = "vgw-tes-rom-prd-aue-01"
}

variable "ip_configuration" {
  description = "The name of the ip_configuration"
  type        = string
  default     = "vnetGatewayConfig"
}

variable "private_ip_address_allocation" {
  description = "The name of the resource's that are created"
  type        = string
}

variable "vpn_type" {
  description = "The name of the vpn_type"
  type        = string
  default     = "RouteBased"
}

variable "gateway_type" {
  description = "The name of the resource's type"
  type        = string
  default     = "Vpn"
}

variable "enable_bgp" {
  description = "The name of the resource's that are created"
  default     = true
}

variable "enable_active_active" {
  description = "If true, an active-active Virtual Network Gateway will be created. An active-active gateway requires a HighPerformance or an UltraPerformance sku. If false, an active-standby gateway will be created. Defaults to false."
  default     = false
}

variable "gateway_address" {
  description = "The IP address of the on-premises VPN gateway."
  type        = string
}

variable "gateway_address2" {
  description = "The IP address of the on-premises VPN gateway."
  type        = string
}

variable "address_space" {
  description = "The address space of the on-premises network."
  type        = list(string)
}

variable "address_space2" {
  description = "The address space of the on-premises network."
  type        = list(string)
}

#dns resolver 

variable "dns_resolver_name" {
  description = "The name of the Private DNS Resolver."
  type        = string
}

variable "inbound_endpoint_name" {
  description = "The name of the inbound endpoint for the Private DNS Resolver."
  type        = string
}

variable "policy_scope" {
  type = string
  description = "Scope for policies to be applied to"
  default = ""
}

#Consumption Budget alert Variables

// variable "mon_resourceGroup_name" {
//   description = "resource group name"
// }

// variable "budget_name" {
//   description = "The name of the Azure Consumption Budget."
//   type        = string
// }

// variable "subscription_id" {
//   description = "The ID of the Azure subscription for which the budget is set."
//   type        = string
// }

// variable "amount" {
//   description = "The amount of the budget in the specified currency."
//   type        = number
// }

// variable "time_grain" {
//   description = "The time period over which the budget is tracked. Possible values are 'Monthly', 'Quarterly', 'Annually'."
//   type        = string
// }

// variable "start_date" {
//   description = "The start date for the budget in the format 'YYYY-MM-DDTHH:MM:SSZ'."
//   type        = string
// }

// variable "end_date" {
//   description = "The end date for the budget in the format 'YYYY-MM-DDTHH:MM:SSZ'."
//   type        = string
// }

// variable "contact_emails" {
//   description = "A list of contact emails for notifications."
//   type        = list(string)
// }

// variable "contact_roles" {
//   description = "A list of contact roles for notifications."
//   type        = list(string)
// }

// variable "notifications" {
//   description = "A map of notifications with threshold, operator, and whether they are enabled."
//   type        = list(object({
//     threshold      = number
//     operator       = string
//     threshold_type = string
//     enabled        = bool
//   }))
// }
// variable "local_gateway_connection_name" {
//   description = "The name of the connection between the Virtual Network Gateway and the Local Network Gateway."
//   type        = string
// }

// variable "subscription_id" {
//   type = string
//   default = null
// }

// variable "workspace_id" {
//   type = string
//   default = "null"
// }


// variable "services" {
//   description = "Defender for Cloud services list to activate. See [https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/security_center_subscription_pricing](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/security_center_subscription_pricing)"
//   type = list(object({
//     resource_type = string
//     tier          = optional(string, "Standard")
//     subplan       = optional(string, null)
//   }))
//   default = [
//     { resource_type = "AppServices" },
//     {
//       resource_type = "Arm"
//       subplan       = "PerSubscription"
//     },
//     { resource_type = "Dns" },
//     {
//       resource_type = "KeyVaults"
//       subplan       = "PerKeyVault"
//     },
//     { resource_type = "SqlServers" },
//     {
//       resource_type = "StorageAccounts"
//       subplan       = "DefenderForStorageV2"
//     }
//   ]
//   nullable = false
// }

// variable "mg_abri_id" {
//   type    = string
//   default = "/providers/Microsoft.Management/managementGroups/mg-abri"
// }

// variable "mg_abri_platform_id" {
//   type    = string
//   default = "/providers/Microsoft.Management/managementGroups/mg-abri-platform"
// }

// variable "mg_abri_ilrnext_id" {
//   type    = string
//   default = "/providers/Microsoft.Management/managementGroups/mg-abri-ilrnext"
// }

// variable "mg_abri_ilrnext_prd_id" {
//   type    = string
//   default = "/providers/Microsoft.Management/managementGroups/mg-abri-ilrnext-prd"
// }

// variable "mg_abri_ilrnext_dev_id" {
//   type    = string
//   default = "/providers/Microsoft.Management/managementGroups/mg-abri-ilrnext-dev"
// }

// variable "mg_abri_ilrnext_stg_id" {
//   type    = string
//   default = "/providers/Microsoft.Management/managementGroups/mg-abri-ilrnext-stg"
// }

// variable "mg_abri_data_id" {
//   type    = string
//   default = "/providers/Microsoft.Management/managementGroups/mg-abri-data"
// }

// variable "mg_abri_data_prd_id" {
//   type    = string
//   default = "/providers/Microsoft.Management/managementGroups/mg-abri-data-prd"
// }

// variable "mg_abri_data_dev_id" {
//   type    = string
//   default = "/providers/Microsoft.Management/managementGroups/mg-abri-data-dev"
// }

// variable "mg_abri_data_stg_id" {
//   type    = string
//   default = "/providers/Microsoft.Management/managementGroups/mg-abri-data-stg"
// }

// variable "mg_abri_landingzones_id" {
//   type    = string
//   default = "/providers/Microsoft.Management/managementGroups/mg-abri-landingzones"
// }

// variable "mg_abri_decommissioned_id" {
//   type    = string
//   default = "/providers/Microsoft.Management/managementGroups/mg-abri-decommissioned"
// }

// variable "mg_abri_innovation_id" {
//   type    = string
//   default = "/providers/Microsoft.Management/managementGroups/mg-abri-innovation"
// }

// variable "mg_abri_parkinglot_id" {
//   type    = string
//   default = "/providers/Microsoft.Management/managementGroups/mg-abri-parkinglot"
// }

// variable "own_management_group_ids" {
//   type    = list(string)
//   default = [

//     "/providers/Microsoft.Management/managementGroups/mg-abri-platform",
//     "/providers/Microsoft.Management/managementGroups/mg-abri-landingzones",
//     "/providers/Microsoft.Management/managementGroups/mg-abri-innovation",
//     "/providers/Microsoft.Management/managementGroups/mg-abri-parkinglot"
//   ]
// }

// variable "management_group_ids" {
//   type    = list(string)
//   default = [

//     "/providers/Microsoft.Management/managementGroups/mg-abri-platform",
//     "/providers/Microsoft.Management/managementGroups/mg-abri-landingzones",
//     "/providers/Microsoft.Management/managementGroups/mg-abri-innovation"
//   ]
// }

