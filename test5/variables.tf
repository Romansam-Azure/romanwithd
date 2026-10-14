variable "resource_group_name" {
  description = "Existing Resource Group"
  type        = string
}

variable "location" {
  description = "Location of the RG"
  type        = string
}

variable "network_manager_name" {
  description = "Name of AVNM"
  type        = string
}

# variables.tf

variable "dns_resolvers" {
  description = "Azure DNS Resolver IP (and any others)"
  type        = list(string)
  default     = ["168.63.129.16"]
}

variable "sccm_domain_controllers" {
  description = "SCCM and Domain Controller IPs/CIDRs"
  type        = list(string)
  default     = [
    "10.150.32.30",
    "10.150.80.0/25",
    "10.151.80.0/25",
    "10.150.32.8",
    "10.150.32.7"
  ]
}

variable "ng_remote_vpn" {
  description = "NG Remote VPN CIDR"
  type        = string
  default     = "172.31.150.0/23"
}

variable "se_vpn" {
  description = "SE VPN CIDR"
  type        = string
  default     = "172.31.160.0/23"
}

variable "mulesoft_frontend" {
  description = "Mulesoft frontend CIDR"
  type        = string
  default     = "10.204.0.0/24"
}

variable "store_np_frontend" {
  description = "NG App Frontend CIDRs"
  type        = list(string)
  default     = ["10.51.17.0/27", "10.51.17.128/27"]
}


# Add more network group references as needed

# Add more network group references as needed



// # AVD Variables

// variable "resource_group_name" {}
// variable "vnet_name" {}
// variable "subnet_name" {}

// variable "key_vault_name" {}
// variable "key_vault_resource_group" {}
// variable "key_vault_secret_name" {}

// variable "host_pool_name" {}
// variable "friendly_name" {}
// variable "scaling_name" {}
// variable "location" {}
// variable "vm_count" {
//   type = number
// }
// variable "vm_size" {}
// variable "admin_username" {}
// variable "enable_scaling_plan" {
//   description = "Whether to enable AVD scaling plan."
//   type        = bool
//   default     = false
// }

// variable "vm_name" {
//   type    = string
//   default = ""
//   description = "VM Name"
// }

// variable "vm_name2" {
//   type    = string
//   default = ""
//   description = "VM Name"
// }

// variable "vm_name3" {
//   type    = string
//   default = ""
//   description = "VM Name"
// }


// variable "subscriptionProd" {
//   type        = string
//   description = "Subscription ID for Production environment"
// }


// variable "existing_scaling_plan_id" {
//   type    = string
//   default = ""
//   description = "ID of existing scaling plan to attach the host pool to"
// }


// variable "friendly_name_2" {
//   type    = string
//   default = ""
//   description = "Friendly name"
// }

// variable "friendly_name_3" {
//   type    = string
//   default = ""
//   description = "Friendly name"
// }

// variable "host_pool_name_3" {
//   type    = string
//   default = ""
//   description = "Host Pool name"
// }

// variable "host_pool_name_2" {
//   type    = string
//   default = ""
//   description = "Host pool name"
// }


// #Enter in your subscription IDs from the Azure tenant here.
// #Production Subscription

// variable "bkstrgrg" {
//   type        = string
//   description = "The name of the backend storage account resource group"
//   default     = "<storage act resource group name>"
// }

// variable "bkstrg" {
//   type        = string
//   description = "The name of the backend storage account"
//   default     = "<storage account name>"
// }

// variable "bkcontainer" {
//   type = string
//   description = "The container name for the backend config"
//   default = "<blob storage container name>"
// }


// #Production Subscription
// variable "subscriptionProd" {
//   description = "Name for Production to add to Management Group"

// }

// #Shared Subscription
// variable "subscriptionShared" {
//   description = "Name for Shared to add to Management Group"
// }


// #Set the default location for resources here ----------------------------------
// variable "location" {
//   description = "Name for location"
// }
// #Location end--------------------------------------------------------------------



// variable "shdtags" {
//   type        = map(any)
//   description = "(Optional) A map of tags to be applied globally on all Azure resources"
//   default     = {}
// }

// variable "prdtags" {
//   type        = map(any)
//   description = "(Optional) A map of tags to be applied globally on all Azure resources"
//   default     = {}
// }

// variable "shd_resource_groups" {
//   type        = map(any)
//   description = "(Required) A list of Azure Resource Groups with locations and tags"
//   default     = {}
// }

// variable "prd_resource_groups" {
//   type        = map(any)
//   description = "(Required) A list of Azure Resource Groups with locations and tags"
//   default     = {}
// }


// // variable "mgt_resource_groups" {
// //   type        = map(any)
// //   description = "(Required) A list of Azure Resource Groups with locations and tags"
// //   default     = {}
// // }


// variable "log_analytics_name" {
//   description = "log analytics name"
// }

// variable "log_analytics_rg_name" {
//   description = "log resource group  name"
// }




// #Recovery Service Vault Variables


// variable "prd_recovery_vault_name" {
//   type = string
//   default = "rsv-ops-prd-aue-001"
// }



// variable "sku" {
//   type = string
//   default = "Standard"
// }

// variable "backup_policy_name" {
//   type = string
//   default = "my-backup-policy"
// }

// variable "rsv_prd_rg_name" {
//   description = "A container that holds related resources for an Azure solution"
// }


// variable "vnet_prd_rg_name" {
//   description = "A container that holds related resources for an Azure solution"
// }

// variable "prd_vnet_name" {
//   description = "A container that holds related resources for an Azure solution"
// }

// variable "vnet_shd_rg_name" {
//   description = "A container that holds related resources for an Azure solution"
// }

// variable "shd_vnet_name" {
//   description = "A container that holds related resources for an Azure solution"
// }

// variable "dns_servers" {
//   description = "Ip address of the dns servers"
// }

// variable "source_address_prefixes" {
//   type        = list(string)
//   default     = null
//   description = "Destination address prefix to be applied to all predefined rules"
// }

// variable "destination_address_prefixes" {
//   type        = list(string)
//   default     = null
//   description = "Destination address prefix to be applied to all predefined rules"
// }




// variable "vnet_id" {
//   description = "The full Azure resource ID of the remote virtual network."
//   default = null
// }

// variable "subnet_id" {
//   description = "The full Azure resource ID of the remote virtual network."
//   default = null
// }


// variable "private_dns_zones" {
//   type    = list(string)
//   default = ["privatelink.blob.core.windows.net", 
//              "privatelink.database.windows.net",
//              "privatelink.file.core.windows.net",
//              "privatelink.vaultcore.azure.net",
//              "privatelink.sql.azuresynapse.net",
//              "privatelink.dev.azuresynapse.net",
//              "privatelink.azurewebsites.net",
//              "scm.privatelink.azurewebsites.net",
//              "privatelink.datafactory.azure.net",
//              "privatelink.adf.azure.com"]
// }

// variable "registration_enabled" {
//   description = "True or False."
//   default     = false
// }

// #Storage Account Vars --------------------
// variable "prd_diag_StorageAccountName" {
//   description = "log analytics name"
// }



// // variable "mgt_diag_StorageAccountName" {
// //   description = "log analytics name"
// // }

// // variable "mgt_nsg_StorageAccountName" {
// //   description = "log analytics name"
// // }

// // variable "mgt_splunk_StorageAccountName" {
// //   description = "log analytics name"
// // }

// // variable "mgt_cloud_StorageAccountName" {
// //   description = "log analytics name"
// // }

// // variable "mgt_boot_StorageAccountName" {
// //   description = "log analytics name"
// // }

// // variable "mgt_retention_StorageAccountName" {
// //   description = "log analytics name"
// // }

// variable "private_blob_dns_zone_ids" {
//   description = "Storage Pep id"
// }

// variable "prd_stodiag_pep_name" {
//   description = "keyvault name"
// }


// variable "prd_sto_rg" {
//   description = "rg name"
// }

// variable "StorageAccountTier" {
//   description = "log analytics Storage Account Tier"
// }
// variable "StorageAccountReplicationType" {
//   description = "log analytics Storage Account Replication Type"
// }
// variable "StorageAccountAllowPublic" {
//   description = "log analytics Storage Account Allow Public"
// }
// variable "StorageAccountTlsVersion" {
//   description = "log analytics Storage Account Tls Version"
// }
// variable "StorageAccountBlobSoftDeleteDays" {
//   description = "log analytics Storage Account Blob Soft Delete Days"
// }
// # Container Name
// # If account_tier is Premium use true
// variable "StorageAccountInfraEncryption" {
//   description = "log analytics Storage Account Infra Encryption"
// }
// variable "StorageAccountHns" {
//   description = "log analytics Storage Account Hns"
// }

// variable "sto_pep_nic_name" {
//   description = "storage pep nic name"
// }


// variable "data_factory_name" {
//   description = "The name of the Data Factory"
// }


// variable "dfresource_group_name" {
//   description = "The name of the resource group"
// }

// variable "sqlResourceGroup" {
//   description = "resource group name"
// }

// variable "sqlserver_name" {
//   description = "storage account name"
// }

// variable "sql_username" {
//   description = "storage account name"
// }

// variable "key_vault_name" {
//   description = "The name of the Key Vault"
// }

// variable "key_vault_resource_group" {
//   description = "The name of the Resource Group where the Key Vault is located"
// }

// variable "key_vault_secret_name" {
//   description = "The name of the secret in Key Vault"
// }


// variable "private_sql_dns_zone_ids" {
//   description = "sql Pep id"
// }

// variable "private_dataf_dns_zone_ids" {
//   description = "datafactory Pep id"
// }

// variable "sql_pep_name" {
//   description = "sql pep name"
// }

// variable "dataf_pep_name" {
//   description = "datafactory pep name"
// }

// variable "sql_pep_nic_name" {
//   description = "sql pep nic name"
// }

// variable "vnet_peering_name" {
//   description = "sql pep nic name"
// }

// variable "dataf_pep_nic_name" {
//   description = "datafactory pep nic name"
// }

// # Public ip 

// variable "public_ip_address_id" {
//   description = "The full Azure resource ID of the remote virtual network."
//   default = null
// }

// variable "publicip_vpn" {
//   type = string
//   default = "vpn_gateway_pip"
// }


// #VPN gateway Variables


// variable "local_gateway_connection_name" {
//   description = "The name of the Virtual Network Gateway connection to the local network"
//   type        = string
// }

// variable "local_gateway_connection_name2" {
//   description = "The name of the Virtual Network Gateway connection to the local network"
//   type        = string
// }

// variable "vpn_gw_sku" {
//   description = "The SKU of the Public IP. Accepted values are Basic and Standard. Defaults to Basic"
//   type        = string
//   default     = "VpnGw1"
// }

// variable "local_gateway_name" {
//   description = "The name of the Local Network Gateway."
//   type        = string
//   default     = "lgw-tes-rom-prd-aue-01"
// }

// variable "local_gateway_name2" {
//   description = "The name of the Local Network Gateway."
//   type        = string
//   default     = "lgw-tes-rom-prd-aue-02"
// }

// variable "vpn_gateway_name" {
//   description = "The name of the vpn_gateway_name"
//   type        = string
//   default     = "vgw-tes-rom-prd-aue-01"
// }

// variable "ip_configuration" {
//   description = "The name of the ip_configuration"
//   type        = string
//   default     = "vnetGatewayConfig"
// }

// variable "private_ip_address_allocation" {
//   description = "The name of the resource's that are created"
//   type        = string
// }

// variable "vpn_type" {
//   description = "The name of the vpn_type"
//   type        = string
//   default     = "RouteBased"
// }

// variable "gateway_type" {
//   description = "The name of the resource's type"
//   type        = string
//   default     = "Vpn"
// }

// variable "enable_bgp" {
//   description = "The name of the resource's that are created"
//   default     = false
// }

// variable "enable_active_active" {
//   description = "If true, an active-active Virtual Network Gateway will be created. An active-active gateway requires a HighPerformance or an UltraPerformance sku. If false, an active-standby gateway will be created. Defaults to false."
//   default     = false
// }

// variable "gateway_address" {
//   description = "The IP address of the on-premises VPN gateway."
//   type        = string
// }

// variable "gateway_address2" {
//   description = "The IP address of the on-premises VPN gateway."
//   type        = string
// }

// variable "address_space" {
//   description = "The address space of the on-premises network."
//   type        = list(string)
// }

// variable "address_space2" {
//   description = "The address space of the on-premises network."
//   type        = list(string)
// }

// #dns resolver 

// variable "dns_resolver_name" {
//   description = "The name of the Private DNS Resolver."
//   type        = string
// }

// variable "inbound_endpoint_name" {
//   description = "The name of the inbound endpoint for the Private DNS Resolver."
//   type        = string
// }

// variable "policy_scope" {
//   type = string
//   description = "Scope for policies to be applied to"
//   default = ""
// }

// #Consumption Budget alert Variables

// // variable "mon_resourceGroup_name" {
// //   description = "resource group name"
// // }

// // variable "budget_name" {
// //   description = "The name of the Azure Consumption Budget."
// //   type        = string
// // }

// // variable "subscription_id" {
// //   description = "The ID of the Azure subscription for which the budget is set."
// //   type        = string
// // }

// // variable "amount" {
// //   description = "The amount of the budget in the specified currency."
// //   type        = number
// // }

// // variable "time_grain" {
// //   description = "The time period over which the budget is tracked. Possible values are 'Monthly', 'Quarterly', 'Annually'."
// //   type        = string
// // }

// // variable "start_date" {
// //   description = "The start date for the budget in the format 'YYYY-MM-DDTHH:MM:SSZ'."
// //   type        = string
// // }

// // variable "end_date" {
// //   description = "The end date for the budget in the format 'YYYY-MM-DDTHH:MM:SSZ'."
// //   type        = string
// // }

// // variable "contact_emails" {
// //   description = "A list of contact emails for notifications."
// //   type        = list(string)
// // }

// // variable "contact_roles" {
// //   description = "A list of contact roles for notifications."
// //   type        = list(string)
// // }

// // variable "notifications" {
// //   description = "A map of notifications with threshold, operator, and whether they are enabled."
// //   type        = list(object({
// //     threshold      = number
// //     operator       = string
// //     threshold_type = string
// //     enabled        = bool
// //   }))
// // }
// // variable "local_gateway_connection_name" {
// //   description = "The name of the connection between the Virtual Network Gateway and the Local Network Gateway."
// //   type        = string
// // }

// // variable "subscription_id" {
// //   type = string
// //   default = null
// // }

// // variable "workspace_id" {
// //   type = string
// //   default = "null"
// // }


