resource_group_name        = "Testresourceforroma"
location                   = "australiaeast"
network_manager_name       = "p-roma-netsegmentation"



// # AVD Tfvars


// resource_group_name       = "Testresourceforroma"
// vnet_name                 = "vnet-avd-tech"
// subnet_name               = "subnet-avd-tech"

// key_vault_name           = "kv-hub-rom-aue-001"
// key_vault_resource_group = "rg-keyvault-pom-aue-001"
// key_vault_secret_name     = "admin-password"

// host_pool_name            = "VDPOOL-Technical-P01-AE"
// friendly_name             = "Personal AVD Pool"
// location                  = "Australia East"
// vm_count                  = 1
// vm_size                   = "Standard_D2s_v3"
// admin_username            = "avdadmin"
// scaling_name              = "SP-AVD-rom-P01-AE"
// friendly_name_2           = "Personal AVD Pool2"
// friendly_name_3           = "Personal AVD Pool3"
// host_pool_name_3          = "VDPOOL-Techn-P03-AE"
// host_pool_name_2          = "VDPOOL-Techn-P02-AE"

// vm_name                   = "avdvmroma"
// vm_name2                   = "avdvmroma2"
// vm_name3                   = "avdvmroma3"


// // // #Enter in your subscription IDs from the Azure tenant here.
// // // #Production Subscription
// // // subscriptionProd = "fd0114fa-4f9f-442d-a079-4dd0462cc7d9" # Change to Clients DMZ Sub ID
// subscriptionProd = "dca9be48-88b1-43e3-adfb-4a8d1ac1220e" # Change to Clients DMZ Sub ID


// #Shared Subscription
// subscriptionShared = "dca9be48-88b1-43e3-adfb-4a8d1ac1220e" # Change to Clients hub Sub ID

// // #Management Subscription
// // subscriptionMgmt = "df391ee9-6b31-427b-82ce-37991aa80ea9" # Change to Clients Management  Sub ID

// #Subscription End -------------------------------------------------------------

// #Set the default location for resources here ----------------------------------
// location = "Australia East" #Default location, should not need to change


// #Resource Group end -------------------------------------------------------------------

// #Policy Tags --------------------------------------------------


// #Configure the names of the management groups -----------------------------------------------
// // mgmt_groups = {
// //   mg-roma-global = {
// //     id       = "mg-roma-global"
// //     name     = "mg-roma-global"
// //     parent   = "80c5281f-a617-4426-9fb1-59a26fbbc9ad"
// //     sub_list = []
// //     level    = 1
// //   }
// //   mg-roma-platform = {
// //     id       = "mg-roma-platform"
// //     name     = "mg-roma-platform"
// //     parent   = "mg-roma-global"
// //     sub_list = []
// //     level    = 2
// //   }
// //   mg-platform-connectivity-roma = {
// //     id       = "mg-platform-connectivity-roma"
// //     name     = "mg-platform-connectivity-roma"
// //     parent   = "mg-roma-platform"
// //     sub_list = ["5d4284d3-81dc-423b-9c03-958c9b459723"]
// //     level    = 3
// //   }
// //   mg-platform-management-roma = {
// //     id       = "mg-platform-management-roma"
// //     name     = "mg-platform-management-roma"
// //     parent   = "mg-roma-platform"
// //     sub_list = ["df391ee9-6b31-427b-82ce-37991aa80ea9"]
// //     level    = 3
// //   }
// //   mg-platform-identity-roma = {
// //     id       = "mg-platform-identity-roma"
// //     name     = "mg-platform-identity-roma"
// //     parent   = "mg-roma-platform"
// //     sub_list = []
// //     level    = 3
// //   }
// //   mg-roma-landingzones = {
// //     id       = "mg-roma-landingzones"
// //     name     = "mg-roma-landingzones"
// //     parent   = "mg-roma-global"
// //     sub_list = []
// //     level    = 2
// //   }
// //   mg-roma-ilrnext = {
// //     id       = "mg-roma-ilrnext"
// //     name     = "mg-roma-ilrnext"
// //     parent   = "mg-roma-landingzones"
// //     sub_list = []
// //     level    = 3
// //   }
// //   mg-roma-ilrnext-dev = {
// //     id       = "mg-roma-ilrnext-dev"
// //     name     = "mg-roma-ilrnext-dev"
// //     parent   = "mg-roma-ilrnext"
// //     sub_list = []
// //     level    = 4
// //   }
// //   mg-roma-ilrnext-staging = {
// //     id       = "mg-roma-ilrnext-staging"
// //     name     = "mg-roma-ilrnext-staging"
// //     parent   = "mg-roma-ilrnext"
// //     sub_list = []
// //     level    = 4
// //   }
// //   mg-roma-ilrnext-prod = {
// //     id       = "mg-roma-ilrnext-prod"
// //     name     = "mg-roma-ilrnext-prod"
// //     parent   = "mg-roma-ilrnext"
// //     sub_list = []
// //     level    = 4
// //   }
// //   mg-roma-data = {
// //     id       = "mg-roma-data"
// //     name     = "mg-roma-data"
// //     parent   = "mg-roma-landingzones"
// //     sub_list = []
// //     level    = 3
// //   }
// //   mg-roma-data-dev = {
// //     id       = "mg-roma-data-dev"
// //     name     = "mg-roma-data-dev"
// //     parent   = "mg-roma-data"
// //     sub_list = []
// //     level    = 4
// //   }
// //   mg-roma-data-preprod = {
// //     id       = "mg-roma-data-preprod"
// //     name     = "mg-roma-data-preprod"
// //     parent   = "mg-roma-data"
// //     sub_list = []
// //     level    = 4
// //   }
// //   mg-roma-data-prod = {
// //     id       = "mg-roma-data-prod"
// //     name     = "mg-roma-data-prod"
// //     parent   = "mg-roma-data"
// //     sub_list = []
// //     level    = 4
// //   }
// //   mg-roma-dmz = {
// //     id       = "mg-roma-dmz"
// //     name     = "mg-roma-dmz"
// //     parent   = "mg-roma-landingzones"
// //     sub_list = ["fd0114fa-4f9f-442d-a079-4dd0462cc7d9"]
// //     level    = 3
// //   }
// //   mg-roma-innovation = {
// //     id       = "mg-roma-innovation"
// //     name     = "mg-roma-innovation"
// //     parent   = "mg-roma-global"
// //     sub_list = []
// //     level    = 2
// //   }
// //   mg-roma-decomm = {
// //     id       = "mg-roma-decomm"
// //     name     = "mg-roma-decomm"
// //     parent   = "mg-roma-global"
// //     sub_list = []
// //     level    = 2
// //   }
// //   mg-roma-parkinglot = {
// //     id       = "mg-roma-parkinglot"
// //     name     = "mg-roma-parkinglot"
// //     parent   = "mg-roma-global"
// //     sub_list = []
// //     level    = 2
// //   }
// // }

// shdtags = {
//   CostCenter  = "CC1001"
//   Environment = "Production"
//   Deployment  = "ProductionDeployment"
// }

// prdtags = {
//   CostCenter  = "CC1001"
//   Environment = "Production"
//   Deployment  = "ProductionDeployment"
// }

// #Resource Group Creation

// # hub_resource_groups.tfvars

// # hub_resource_groups.tfvars

// shd_resource_groups = {
//   "rg-storage-rom-aue-001" = {
//     location = ""
//     tags = ""
//   }
//   "rg-network-rom-aue-001" = {
//     location = ""
//     tags = ""
//   }
//   "rg-loganalytics-rom-aue-001"  = {
//     location = ""
//     tags = ""
//   }
//   "rg-dns-rom-aue-001"   = {
//     location = ""
//     tags = ""
//   }
// }


// prd_resource_groups = {
//   "rg-storage-pom-aue-001" = {
//     location = ""
//     tags = ""
//   }
//   "rg-network-pom-aue-001" = {
//     location = ""
//     tags = ""
//   }
//   "rg-reporting-pom-aue-001"  = {
//     location = ""
//     tags = ""
//   }
//   "sqls-reporting-pom-aue-01"  = {
//     location = ""
//     tags = ""
//   }
//   "rg-recoveryvault-pom-aue-001"  = {
//     location = ""
//     tags = ""
//   }
// }





// // # mgt_resource_groups.tfvars

// // mgt_resource_groups = {
// //   "rg-mgt-rom-prd-paasservices-aue-01" = {
// //     location = ""
// //     tags = ""
// //   }
// //   "rg-mgt-rom-prd-automation-aue-01"  = {
// //     location = ""
// //     tags = ""
// //   }
// //   "rg-mgt-rom-prd-identities-aue-01" = {
// //     location = ""
// //     tags = ""
// //   }
// //   "rg-mgt-rom-prd-loganalytics-aue-01" = {
// //     location = ""
// //     tags = ""
// //   }
// //   "rg-mgt-rom-prd-ascexports-aue-01"  = {
// //     location = ""
// //     tags = ""
// //   }
// //   "rg-mgt-rom-prd-monitoring-aue-01"  = {
// //     location = ""
// //     tags = ""
// //   }
// //   "rg-mgt-rom-prd-storage-aue-01"  = {
// //     location = ""
// //     tags = ""
// //   }
// // }



// // datafactory_rg_name = "rg-tes-rom-prd-datafactory-aue-01"

// // sql_rg_name = "rg-tes-rom-prd-sqls-aue-01"

// // sqlserver_name = "romasqltest01"

// // sql_username = "adminh"

// // sql_password = "Newyear@1234mr"

// # Storage Account Vars
// shd_vnet_name = "vnet-hub-rom-aue-01"

// vnet_shd_rg_name = "rg-network-rom-aue-001"

// prd_vnet_name = "vnet-spoke-pom-aue-001"

// vnet_prd_rg_name = "rg-network-pom-aue-001"

// dns_servers = [ "10.150.0.4" ]


// // datafactory_rg_name = "rg-tes-rom-prd-datafactory-aue-01"

// // sql_rg_name = "rg-tes-rom-prd-sqls-aue-01"

// // sqlserver_name = "romasqltest01"

// // sql_username = "adminh"

// // sql_password = "Newyear@1234mr"

// # Storage Account Vars
// prd_diag_StorageAccountName = "sahubootdiaglosaue11" # Replace with the actual name
// // hub_boot_StorageAccountName = "sahubrombootdiagaue01" # Replace with the actual name
// // mgt_diag_StorageAccountName = "samgtromdiaglogsaue01" # Replace with the actual name
// // mgt_nsg_StorageAccountName = "samgtromnsgflogsaue01"   # Replace with the actual name
// // mgt_splunk_StorageAccountName = "samgtromsiemlogsaue01" # Replace with the actual name
// // mgt_cloud_StorageAccountName = "samgtromcloudshlaue01" # Replace with the actual name
// // mgt_boot_StorageAccountName = "samgtrombootdiagaue01" # Replace with the actual name
// // mgt_retention_StorageAccountName = "samgmtromdiaglogsaue01" # Replace with the actual name

// #Storage Account Vars --------------------

// StorageAccountTier                    = "Standard"
// StorageAccountReplicationType         = "LRS"
// StorageAccountAllowPublic             = "false"
// StorageAccountTlsVersion              = "TLS1_2"
// StorageAccountBlobSoftDeleteDays      = 7

// # Container Name

// # If account_tier is Premium use true
// StorageAccountInfraEncryption = "false"
// StorageAccountHns             = "false"

// private_blob_dns_zone_ids = ["/subscriptions/dca9be48-88b1-43e3-adfb-4a8d1ac1220e/resourceGroups/rg-network-rom-aue-001/providers/Microsoft.Network/privateDnsZones/privatelink.blob.core.windows.net"]

// private_sql_dns_zone_ids = ["/subscriptions/dca9be48-88b1-43e3-adfb-4a8d1ac1220e/resourceGroups/rg-network-rom-aue-001/providers/Microsoft.Network/privateDnsZones/privatelink.database.windows.net"]

// private_dataf_dns_zone_ids = ["/subscriptions/dca9be48-88b1-43e3-adfb-4a8d1ac1220e/resourceGroups/rg-network-rom-aue-001/providers/Microsoft.Network/privateDnsZones/privatelink.datafactory.azure.net"]

// prd_stodiag_pep_name = "sto-hub-rom-diag-pep-01"


// prd_sto_rg = "rg-storage-pom-aue-001"

// sto_pep_nic_name = "sto-diag-pom-diag-pep-nic-01"


// data_factory_name = "adf-reporting-pom-aue-01"

// dfresource_group_name = "rg-reporting-pom-aue-001"

// #SQL server Varaiables

// sqlserver_name           = "sqls-reporting-pom-aue-01"
// sqlResourceGroup         = "rg-reporting-pom-aue-001"
// sql_username             = "sqladmin"
// key_vault_name           = "kv-hub-rom-aue-001"
// key_vault_resource_group = "rg-keyvault-pom-aue-001"
// key_vault_secret_name    = "sqlpass"

// sql_pep_name              = "sql-prd-rom-pep-01"
// dataf_pep_name            = "dataf-prd-rom-pep-01"
// sql_pep_nic_name          = "sql-prd-rom-pep-nic-01"
// dataf_pep_nic_name        = "dataf-prd-rom-pep-nic-01"

// #VPN Varaiables

// local_gateway_connection_name = "newconnectionwithonprem"

// local_gateway_connection_name2 = "newconnectionwithonprem2"

// private_ip_address_allocation = "Dynamic"
// gateway_address           = "192.168.1.1"
// address_space             = ["10.0.0.0/16", "10.1.0.0/16"]

// gateway_address2           = "192.168.1.2"
// address_space2             = ["10.0.0.0/16", "10.1.0.0/16"]


// dns_resolver_name      = "my-dns-resolver"
// inbound_endpoint_name  = "my-inbound-endpoint"

// policy_scope     = "/subscriptions/dca9be48-88b1-43e3-adfb-4a8d1ac1220e"

// // policy_scope1     = "/subscriptions/06ac9c04-a7f2-44f8-bdd4-2bad250f2a6a"

// rsv_prd_rg_name = "rg-recoveryvault-pom-aue-001"

// log_analytics_name = "loganalytics-rom-aue-01"


// log_analytics_rg_name = "rg-loganalytics-rom-aue-001"

// vnet_peering_name = "vnet-hub-rom-aue-001-to-vnet-spoke-pom-aue-001"
// # Cosumption Budjet Variables

// // mon_resourceGroup_name = "rg-reporting-prd-aue-001"
// // budget_name         = "Monthly-Azure-Budget"
// // subscription_id     = "/subscriptions/dca9be48-88b1-43e3-adfb-4a8d1ac1220e"
// // amount              = 1000.00
// // time_grain          = "Monthly"
// // start_date          = "2024-09-01T00:00:00Z"
// // end_date            = "2025-09-01T00:00:00Z"

// // contact_emails = [
// //   "roman.nehru@datacom.com",
// //   "roman.nehru@datacom.com"
// // ]


// // contact_roles = ["Contributor", "Owner"]

// // notifications = [
// //   {
// //     threshold      = 80
// //     operator       = "GreaterThan"
// //     threshold_type = "Actual"
// //     enabled        = true
// //   },
// //   {
// //     threshold      = 100
// //     operator       = "GreaterThanOrEqualTo"
// //     threshold_type = "Forecasted"
// //     enabled        = true
// //   }
// // ]

