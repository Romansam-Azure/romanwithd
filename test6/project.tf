# Common Tags
locals {
  common_tags = {
    "Project.Code"             = "N.571.25.6795"
    "Business.EnvironmentType" = "prd"
  }

  region_codes = {
    "australiaeast"      = "ae"
    "australiasoutheast" = "ase"
  }
}

// # Resource Groups rg-avd-p01-ae
// module "rg_avd_p01_ae" {
//   source   = "./modules/resource_group"
//   name     = "rg-avd-p01-ae"
//   location = "australiaeast"
//   tags     = merge(local.common_tags, {
//     "Business.Application" = "avd"
//     "Object.ResourceType"  = "rg"
//     "Object.Region"        = local.region_codes["australiaeast"]
//   })
// }

// # Resource Groups rg-avd-p02-ae
// module "rg_avd_p02_ae" {
//   source   = "./modules/resource_group"
//   name     = var.resource_group_name
//   location = "australiaeast"
//   tags     = merge(local.common_tags, {
//     "Business.Application" = "avd"
//     "Object.ResourceType"  = "rg"
//     "Object.Region"        = local.region_codes["australiaeast"]
//   })
// }

// # Resource Groups rg-avd-p03-ae
// module "rg_avd_p03_ae" {
//   source   = "./modules/resource_group"
//   name     = "rg-avd-p03-ae"
//   location = "australiaeast"
//   tags     = merge(local.common_tags, {
//     "Business.Application" = "avd"
//     "Object.ResourceType"  = "rg"
//     "Object.Region"        = local.region_codes["australiaeast"]
//   })
// }

// # Resource Groups rg-avd-p05-ae
// module "rg_avd_p05_ae" {
//   source   = "./modules/resource_group"
//   name     = "rg-avd-p05-ae"
//   location = "australiaeast"
//   tags     = merge(local.common_tags, {
//     "Business.Application" = "avd"
//     "Object.ResourceType"  = "rg"
//     "Object.Region"        = local.region_codes["australiaeast"]
//   })
// }

// # Resource Groups rg-avd-p04-ae
// module "rg_avd_p04_ae" {
//   source   = "./modules/resource_group"
//   name     = "rg-avd-p04-ae"
//   location = "australiaeast"
//   tags     = merge(local.common_tags, {
//     "Business.Application" = "avd"
//     "Object.ResourceType"  = "rg"
//     "Object.Region"        = local.region_codes["australiaeast"]
//   })
// }

// # Resource Groups rg-avd-u01-ae
// module "rg_avd_u01_ae" {
//   source   = "./modules/resource_group"
//   name     = "rg-avd-u01-ae"
//   location = "australiaeast"
//   tags     = merge(local.common_tags, {
//     "Business.Application" = "avd"
//     "Object.ResourceType"  = "rg"
//     "Object.Region"        = local.region_codes["australiaeast"]
//   })
// }

// # Resource Groups rg-avd-networking-p01-ae
// module "rg_avd_networking_p01_ae" {
//   source   = "./modules/resource_group"
//   name     = "rg-avd-networking-p01-ae"
//   location = "australiaeast"
//   tags     = merge(local.common_tags, {
//     "Business.Application" = "Virtual Networking"
//     "Object.ResourceType"  = "rg"
//     "Object.Region"        = local.region_codes["australiaeast"]
//     "ResourceGroup.Lock " =  "Enabled"
//   })
// }


// #Australis East Resource Groups 

// # Resource Groups rg-avd-p01-ase
// module "rg_avd_p01_ase" {
//   source   = "./modules/resource_group"
//   name     = "rg-avd-p01-ase"
//   location = "australiasoutheast"
//   tags     = merge(local.common_tags, {
//     "Business.Application" = "avd"
//     "Object.ResourceType"  = "rg"
//     "Object.Region"        = local.region_codes["australiasoutheast"]
//   })
// }

// # Resource Groups rg-avd-p02-ase
// module "rg_avd_p02_ase" {
//   source   = "./modules/resource_group"
//   name     = "rg-avd-p02-ase"
//   location = "australiasoutheast"
//   tags     = merge(local.common_tags, {
//     "Business.Application" = "avd"
//     "Object.ResourceType"  = "rg"
//     "Object.Region"        = local.region_codes["australiasoutheast"]
//   })
// }

// # Resource Groups rg-avd-p03-ase
// module "rg_avd_p03_ase" {
//   source   = "./modules/resource_group"
//   name     = "rg-avd-p03-ase"
//   location = "australiasoutheast"
//   tags     = merge(local.common_tags, {
//     "Business.Application" = "avd"
//     "Object.ResourceType"  = "rg"
//     "Object.Region"        = local.region_codes["australiasoutheast"]
//   })
// }

// # Resource Groups rg-avd-p04-ase
// module "rg_avd_p04_ase" {
//   source   = "./modules/resource_group"
//   name     = "rg-avd-p04-ase"
//   location = "australiasoutheast"
//   tags     = merge(local.common_tags, {
//     "Business.Application" = "avd"
//     "Object.ResourceType"  = "rg"
//     "Object.Region"        = local.region_codes["australiasoutheast"]
//   })
// }

// # Resource Groups rg-avd-p05-ase
// module "rg_avd_p05_ase" {
//   source   = "./modules/resource_group"
//   name     = "rg-avd-p05-ase"
//   location = "australiasoutheast"
//   tags     = merge(local.common_tags, {
//     "Business.Application" = "avd"
//     "Object.ResourceType"  = "rg"
//     "Object.Region"        = local.region_codes["australiasoutheast"]
//   })
// }

// # Resource Groups rg-avd-networking-p01-ase
// module "rg_avd_networking_p01_ase" {
//   source   = "./modules/resource_group"
//   name     = "rg-avd-networking-p01-ase"
//   location = "australiasoutheast"
//   tags     = merge(local.common_tags, {
//     "Business.Application" = "Virtual Networking"
//     "Object.ResourceType"  = "rg"
//     "Object.Region"        = local.region_codes["australiasoutheast"]
//     "ResourceGroup.Lock " =  "Enabled"
//   })
// }


# ✅ Optional: Key Vault and Secret (example)
data "azurerm_key_vault" "keyvault" {
  name                = var.key_vault_name
  resource_group_name = var.key_vault_resource_group
}

data "azurerm_key_vault_secret" "admin_password" {
  name         = var.key_vault_secret_name
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

locals {
  common_vnet_tags = {
    "Business.Application"     = "Virtual Networking"
    "Business.EnvironmentType" = "prd"
    "Object.Region"            = "ase"
    "Project.Code"            = "N.571.25.6795"
  }
}


locals {
  common_vnet_tags_ae = {
    "Business.Application"     = "Virtual Networking"
    "Business.EnvironmentType" = "prd"
    "Object.Region"            = "ae"
    "Project.Code"            = "N.571.25.6795"
  }
}

// # Network Security Group Module AE
// module "network_security_group_ae" {
//   source              = "./modules/network_security_group"
//   resource_group_name = "rg-avd-networking-p01-ae"
//   location            = "australiaeast"
//   common_tags         = local.common_vnet_tags_ae
//   network_security_groups = {
//     "nsg-avd-p01-ae" = {
//       rules = [
//         {
//           name                       = "Allow_UDP_3390_RDP_Shortpath"
//           priority                   = 100
//           direction                  = "Inbound"
//           access                     = "Allow"
//           protocol                   = "Udp"
//           source_port_range          = "*"
//           destination_port_range     = "3390"
//           source_address_prefix      = "*"
//           destination_address_prefix = "*"
//         },
//         {
//           name                       = "test"
//           priority                   = 110
//           direction                  = "Inbound"
//           access                     = "Allow"
//           protocol                   = "*"
//           source_port_range          = "*"
//           destination_port_range     = "1000"
//           source_address_prefix      = "*"
//           destination_address_prefix = "*"
//         }
//       ]
//     },
//     "nsg-avd-p02-ae" = {
//       rules = [
//         {
//           name                       = "Allow_UDP_3390_RDP_Shortpath"
//           priority                   = 100
//           direction                  = "Inbound"
//           access                     = "Allow"
//           protocol                   = "Udp"
//           source_port_range          = "*"
//           destination_port_range     = "3390"
//           source_address_prefix      = "*"
//           destination_address_prefix = "*"
//         }
//       ]
//     },
//     "nsg-avd-p03-ae" = {
//       rules = [
//         {
//           name                       = "Allow_UDP_3390_RDP_Shortpath"
//           priority                   = 100
//           direction                  = "Inbound"
//           access                     = "Allow"
//           protocol                   = "Udp"
//           source_port_range          = "*"
//           destination_port_range     = "3390"
//           source_address_prefix      = "*"
//           destination_address_prefix = "*"
//         }
//       ]
//     },
//     "nsg-avd-p04-ae" = {
//       rules = [
//         {
//           name                       = "Allow_UDP_3390_RDP_Shortpath"
//           priority                   = 100
//           direction                  = "Inbound"
//           access                     = "Allow"
//           protocol                   = "Udp"
//           source_port_range          = "*"
//           destination_port_range     = "3390"
//           source_address_prefix      = "*"
//           destination_address_prefix = "*"
//         }
//       ]
//     },
//     # Default rules only — no custom rules required
//     "nsg-avd-endpoint-p01-ae" = {
//       rules = []
//     },
//     "nsg-avd-endpoint-p02-ae" = {
//       rules = []
//     }
//   }
// }


// # Route Table Module AE
// module "route_table_ae" {
//   source              = "./modules/route_table"
//   resource_group_name = "rg-avd-networking-p01-ae"
//   location            = "australiaeast"
//   common_tags         = local.common_vnet_tags_ae
//   route_tables        = {
//     "udr-avd-p01-ae" = {
//       routes = [
//         {
//           name                   = "default-route"
//           address_prefix         = "0.0.0.0/0"
//           next_hop_type          = "VirtualAppliance"
//           next_hop_in_ip_address = "10.246.0.132"
//         },
//         {
//           name            = "AVD"
//           address_prefix  = "WindowsVirtualDesktop"
//           next_hop_type   = "Internet"
//         }
//       ]
//     },
//     "udr-avd-p02-ae" = {
//       routes = [
//         {
//           name                   = "default-route"
//           address_prefix         = "0.0.0.0/0"
//           next_hop_type          = "VirtualAppliance"
//           next_hop_in_ip_address = "10.246.0.132"
//         },
//         {
//           name            = "AVD"
//           address_prefix  = "WindowsVirtualDesktop"
//           next_hop_type   = "Internet"
//         }
//       ]
//     }
//   }
// }

// # Virtual Network Module AE
// module "virtual_network_ae" {
//   source              = "./modules/virtual_network"
//   resource_group_name = "rg-avd-networking-p01-ae"
//   location            = "australiaeast"
//   common_tags         = local.common_vnet_tags_ae
//   nsg_ids             = module.network_security_group_ae.nsg_ids
//   route_table_ids     = module.route_table_ae.route_table_ids
//   virtual_networks    = {
//     "vnet-avd-p01-ae" = {
//       address_space      = ["10.246.64.0/23"]
//       dns_servers        = ["10.246.1.4"]
//       encryption_enabled = true
//       subnets = [
//         {
//           name                                 = "snet-avd-p01-ae"
//           address_prefixes                     = ["10.246.64.0/24"]
//           nsg_name                             = "nsg-avd-p01-ae"
//           route_table_name                     = "udr-avd-p01-ae"
//           private_endpoint_network_policies_enabled = false
//           private_link_service_network_policies_enabled = true
//           service_endpoints                    = ["Microsoft.KeyVault", "Microsoft.Storage"]
//         },
//         {
//           name                                 = "snet-avd-p02-ae"
//           address_prefixes                     = ["10.246.65.0/25"]
//           nsg_name                             = "nsg-avd-p02-ae"
//           route_table_name                     = "udr-avd-p01-ae"
//           private_endpoint_network_policies_enabled = false
//           private_link_service_network_policies_enabled = true
//           service_endpoints                    = ["Microsoft.KeyVault", "Microsoft.Storage"]
//         },
//         {
//           name                                 = "snet-avd-p03-ae"
//           address_prefixes                     = ["10.246.65.144/28"]
//           nsg_name                             = "nsg-avd-p03-ae"
//           route_table_name                     = "udr-avd-p01-ae"
//           private_endpoint_network_policies_enabled = false
//           private_link_service_network_policies_enabled = true
//           service_endpoints                    = ["Microsoft.KeyVault", "Microsoft.Storage"]
//         },
//         {
//           name                                 = "snet-avd-endpoint-p01-ae"
//           address_prefixes                     = ["10.246.65.128/28"]
//           nsg_name                             = "nsg-avd-endpoint-p01-ae"
//           route_table_name                     = "udr-avd-p01-ae"
//           private_endpoint_network_policies_enabled = true
//           private_link_service_network_policies_enabled = true
//           service_endpoints                    = ["Microsoft.KeyVault", "Microsoft.Storage"]
//         },
//         {
//           name                                 = "AzureBastionSubnet"
//           address_prefixes                     = ["10.246.65.192/26"]
//           nsg_name                             = ""
//           route_table_name                     = ""
//           private_endpoint_network_policies_enabled = false
//           private_link_service_network_policies_enabled = true
//           service_endpoints                    = ["Microsoft.KeyVault", "Microsoft.Storage"]
//         }
//       ]
//     },
//     "vnet-avd-p02-ae" = {
//       address_space      = ["10.246.66.0/23"]
//       dns_servers        = ["10.246.1.4"]
//       encryption_enabled = true
//       subnets = [
//         {
//           name                                 = "snet-avd-p04-ae"
//           address_prefixes                     = ["10.246.66.0/24"]
//           nsg_name                             = "nsg-avd-p04-ae"
//           route_table_name                     = "udr-avd-p02-ae"
//           private_endpoint_network_policies_enabled = false
//           private_link_service_network_policies_enabled = true
//           service_endpoints                    = ["Microsoft.KeyVault", "Microsoft.Storage"]
//         },
//         {
//           name                                 = "snet-avd-endpoint-p02-ae"
//           address_prefixes                     = ["10.246.67.0/24"]
//           nsg_name                             = "nsg-avd-endpoint-p02-ae"
//           route_table_name                     = "udr-avd-p02-ae"
//           private_endpoint_network_policies_enabled = true
//           private_link_service_network_policies_enabled = true
//           service_endpoints                    = ["Microsoft.KeyVault", "Microsoft.Storage"]
//         }
//       ]
//     }
//   }
//   virtual_network_peerings = {
//     "vnet-avd-p01-ae" = {
//       name                      = "avd-hub-p01-ae"
//       remote_virtual_network_id = "/subscriptions/e2e6fc44-f2c5-498f-94c5-c4d271ed21ae/resourceGroups/rg-hub-networking-p01-ae/providers/Microsoft.Network/virtualNetworks/vnet-hub-p01-ae"
//     },
//     "vnet-avd-p02-ae" = {
//       name                      = "avd-hub-p02-ae"
//       remote_virtual_network_id = "/subscriptions/e2e6fc44-f2c5-498f-94c5-c4d271ed21ae/resourceGroups/rg-hub-networking-p01-ae/providers/Microsoft.Network/virtualNetworks/vnet-hub-p01-ae"
//     }
//   }
// }

// # Network Security Group Module ASE
// module "network_security_group" {
//   source              = "./modules/network_security_group"
//   resource_group_name = "rg-avd-networking-p01-ase"
//   location            = "australiasoutheast"
//   common_tags         = local.common_vnet_tags

//   network_security_groups = {
//     "nsg-avd-p01-ase" = {
//       rules = [
//         {
//           name                       = "Allow_UDP_3390_RDP_Shortpath"
//           priority                   = 100
//           direction                  = "Inbound"
//           access                     = "Allow"
//           protocol                   = "Udp"
//           source_port_range          = "*"
//           destination_port_range     = "3390"
//           source_address_prefix      = "*"
//           destination_address_prefix = "*"
//         },
//         {
//           name                       = "test"
//           priority                   = 110
//           direction                  = "Inbound"
//           access                     = "Allow"
//           protocol                   = "*"
//           source_port_range          = "*"
//           destination_port_range     = "1000"
//           source_address_prefix      = "*"
//           destination_address_prefix = "*"
//         }
//       ]
//     },
//     "nsg-avd-p02-ase" = {
//       rules = [
//         {
//           name                       = "Allow_UDP_3390_RDP_Shortpath"
//           priority                   = 100
//           direction                  = "Inbound"
//           access                     = "Allow"
//           protocol                   = "Udp"
//           source_port_range          = "*"
//           destination_port_range     = "3390"
//           source_address_prefix      = "*"
//           destination_address_prefix = "*"
//         }
//       ]
//     },
//     "nsg-avd-p03-ase" = {
//       rules = [
//         {
//           name                       = "Allow_UDP_3390_RDP_Shortpath"
//           priority                   = 100
//           direction                  = "Inbound"
//           access                     = "Allow"
//           protocol                   = "Udp"
//           source_port_range          = "*"
//           destination_port_range     = "3390"
//           source_address_prefix      = "*"
//           destination_address_prefix = "*"
//         }
//       ]
//     },
//     "nsg-avd-p04-ase" = {
//       rules = [
//         {
//           name                       = "Allow_UDP_3390_RDP_Shortpath"
//           priority                   = 100
//           direction                  = "Inbound"
//           access                     = "Allow"
//           protocol                   = "Udp"
//           source_port_range          = "*"
//           destination_port_range     = "3390"
//           source_address_prefix      = "*"
//           destination_address_prefix = "*"
//         }
//       ]
//     },
//     # Default rules only — no custom rules required
//     "nsg-avd-endpoint-p01-ase" = {
//       rules = []
//     },
//     "nsg-avd-endpoint-p02-ase" = {
//       rules = []
//     }
//   }
// }


// # Route Table Module ASE
// module "route_table" {
//   source              = "./modules/route_table"
//   resource_group_name = "rg-avd-networking-p01-ase"
//   location            = "australiasoutheast"
//   common_tags         = local.common_vnet_tags
//   route_tables        = {
//     "udr-avd-p01-ase" = {
//       routes = [
//         {
//           name                   = "default-route"
//           address_prefix         = "0.0.0.0/0"
//           next_hop_type          = "VirtualAppliance"
//           next_hop_in_ip_address = "10.247.0.132"
//         },
//         {
//           name            = "AVD"
//           address_prefix  = "WindowsVirtualDesktop"
//           next_hop_type   = "Internet"
//         }
//       ]
//     },
//     "udr-avd-p02-ase" = {
//       routes = [
//         {
//           name                   = "default-route"
//           address_prefix         = "0.0.0.0/0"
//           next_hop_type          = "VirtualAppliance"
//           next_hop_in_ip_address = "10.247.0.132"
//         },
//         {
//           name            = "AVD"
//           address_prefix  = "WindowsVirtualDesktop"
//           next_hop_type   = "Internet"
//         }
//       ]
//     }
//   }
// }

// # Virtual Network Module ASE
// module "virtual_network" {
//   source              = "./modules/virtual_network"
//   resource_group_name = "rg-avd-networking-p01-ase"
//   location            = "australiasoutheast"
//   common_tags         = local.common_vnet_tags
//   nsg_ids             = module.network_security_group.nsg_ids
//   route_table_ids     = module.route_table.route_table_ids
//   virtual_networks    = {
//     "vnet-avd-p01-ase" = {
//       address_space      = ["10.247.64.0/23"]
//       dns_servers        = ["10.247.1.4"]
//       encryption_enabled = true
//       subnets = [
//         {
//           name                                 = "snet-avd-p01-ase"
//           address_prefixes                     = ["10.247.64.0/24"]
//           nsg_name                             = "nsg-avd-p01-ase"
//           route_table_name                     = "udr-avd-p01-ase"
//           private_endpoint_network_policies_enabled = false
//           private_link_service_network_policies_enabled = true
//           service_endpoints                    = ["Microsoft.KeyVault", "Microsoft.Storage"]
//         },
//         {
//           name                                 = "snet-avd-p02-ase"
//           address_prefixes                     = ["10.247.65.0/25"]
//           nsg_name                             = "nsg-avd-p02-ase"
//           route_table_name                     = "udr-avd-p01-ase"
//           private_endpoint_network_policies_enabled = false
//           private_link_service_network_policies_enabled = true
//           service_endpoints                    = ["Microsoft.KeyVault", "Microsoft.Storage"]
//         },
//         {
//           name                                 = "snet-avd-p03-ase"
//           address_prefixes                     = ["10.247.65.144/28"]
//           nsg_name                             = "nsg-avd-p03-ase"
//           route_table_name                     = "udr-avd-p01-ase"
//           private_endpoint_network_policies_enabled = false
//           private_link_service_network_policies_enabled = true
//           service_endpoints                    = ["Microsoft.KeyVault", "Microsoft.Storage"]
//         },
//         {
//           name                                 = "snet-avd-endpoint-p01-ase"
//           address_prefixes                     = ["10.247.65.128/28"]
//           nsg_name                             = "nsg-avd-endpoint-p01-ase"
//           route_table_name                     = "udr-avd-p01-ase"
//           private_endpoint_network_policies_enabled = true
//           private_link_service_network_policies_enabled = true
//           service_endpoints                    = ["Microsoft.KeyVault", "Microsoft.Storage"]
//         }
//       ]
//     },
//     "vnet-avd-p02-ase" = {
//       address_space      = ["10.247.66.0/23"]
//       dns_servers        = ["10.247.1.4"]
//       encryption_enabled = true
//       subnets = [
//         {
//           name                                 = "snet-avd-p04-ase"
//           address_prefixes                     = ["10.247.66.0/24"]
//           nsg_name                             = "nsg-avd-p04-ase"
//           route_table_name                     = "udr-avd-p02-ase"
//           private_endpoint_network_policies_enabled = false
//           private_link_service_network_policies_enabled = true
//           service_endpoints                    = ["Microsoft.KeyVault", "Microsoft.Storage"]
//         },
//         {
//           name                                 = "snet-avd-endpoint-p02-ase"
//           address_prefixes                     = ["10.247.67.0/24"]
//           nsg_name                             = "nsg-avd-endpoint-p02-ase"
//           route_table_name                     = "udr-avd-p02-ase"
//           private_endpoint_network_policies_enabled = true
//           private_link_service_network_policies_enabled = true
//           service_endpoints                    = ["Microsoft.KeyVault", "Microsoft.Storage"]
//         }
//       ]
//     }
//   }
//   virtual_network_peerings = {
//     "vnet-avd-p01-ase" = {
//       name                      = "avd-hub-p01-ase"
//       remote_virtual_network_id = "/subscriptions/e2e6fc44-f2c5-498f-94c5-c4d271ed21ae/resourceGroups/rg-hub-networking-p01-ase/providers/Microsoft.Network/virtualNetworks/vnet-hub-p01-ase"
//     },
//     "vnet-avd-p02-ase" = {
//       name                      = "avd-hub-p02-ase"
//       remote_virtual_network_id = "/subscriptions/e2e6fc44-f2c5-498f-94c5-c4d271ed21ae/resourceGroups/rg-hub-networking-p01-ase/providers/Microsoft.Network/virtualNetworks/vnet-hub-p01-ase"
//     }
//   }
// }


// # ✅ Module Call Personal avd ae rg-avd-p01-ae
// module "avd_p01_ae" {
//   source              = "./modules/virtualdesktop"
//   host_pool_name      = "vdpool-personal-general-access-p01-ae"
//   friendly_name       = "General production personal desktops"
//   vmhost_name         = "avdp-aep1"
//   location            = var.location
//   resource_group_name = module.rg_avd_p01_ae.name
//   subnet_id           = module.virtual_network_ae.subnet_ids["vnet-avd-p01-ae"]["snet-avd-p01-ae"]
//   vm_count            = 5
//   // vm_count            = var.vm_count
//   vm_size             = var.vm_size
//   admin_username      = "avd-local-admin"
//   admin_password      = data.azurerm_key_vault_secret.admin_password.value
//   applicationgroupname  = "vdag-vdpool-personal-general-access-p01-ae"
//   existing_workspace_id  = var.existing_workspace_id
//   aad_group_display_name = "gsg-prd-user-avdpersonalgeneralaccessp01ae"
//   default_desktop_display_name = "Personal General Desktop"
//   zone = 2

//   providers = {
//      azurerm = azurerm.production
//    }
// }

// # Module call for Personal AVD in rg-avd-p01-ae
// module "avd_p01_ae" {
//   source              = "./modules/virtualdesktop"
//   host_pool_name      = "vdpool-personal-general-access-p01-ae"
//   friendly_name       = "General production personal desktops"
//   vmhost_name         = "avdp-aep1"
//   location            = var.location
//   resource_group_name = module.rg_avd_p01_ae.name
//   subnet_id           = module.virtual_network_ae.subnet_ids["vnet-avd-p01-ae"]["snet-avd-p01-ae"]
//   vm_count            = 6
//   vm_size             = var.vm_size
//   admin_username      = "avd-local-admin"
//   admin_password      = data.azurerm_key_vault_secret.admin_password.value
//   applicationgroupname  = "vdag-vdpool-personal-general-access-p01-ae"
//   existing_workspace_id  = var.existing_workspace_id
//   aad_group_display_name = "gsg-prd-user-avdpersonalgeneralaccessp01ae"
//   default_desktop_display_name = "Personal General Desktop"
//   zone                = 2
//   key_vault_id        = data.azurerm_key_vault.keyvault.id # Pass Key Vault ID to module
//   // avd_register_session_host_modules_url = var.avd_register_session_host_modules_url

//   providers = {
//     azurerm = azurerm.production
//   }
// }


// # ✅ Module Call Personal avd ae rg-avd-p02-ae
// module "avd" {
//   source              = "./modules/virtualdesktop"
//   host_pool_name      = var.host_pool_name
//   friendly_name       = var.friendly_name
//   vmhost_name         = var.vmhost_name
//   location            = var.location
//   resource_group_name = module.rg_avd_p02_ae.name
//   subnet_id           = module.virtual_network_ae.subnet_ids["vnet-avd-p01-ae"]["snet-avd-p02-ae"]
//   vm_count            = 0
//   // vm_count            = var.vm_count
//   vm_size             = var.vm_size
//   admin_username      = "avd-local-admin"
//   admin_password      = data.azurerm_key_vault_secret.admin_password.value
//   applicationgroupname  = var.applicationgroupname
//   existing_workspace_id  = var.existing_workspace_id
//   aad_group_display_name = "gsg-prd-user-avdpersonalvendorp02ae"
//   default_desktop_display_name = "Personal Vendor Desktop"
//   key_vault_id        = data.azurerm_key_vault.keyvault.id # Pass Key Vault ID to module

//   providers = {
//      azurerm = azurerm.production
//    }
// }




// # ✅ Module Call Personal avd ae  rg-avd-p03-ae
// module "avd2" {
//   source              = "./modules/virtualdesktop"
//   host_pool_name      = var.host_pool_name2
//   friendly_name       = var.friendly_name2
//   vmhost_name         = var.vmhost_name2
//   location            = var.location
//   resource_group_name = module.rg_avd_p03_ae.name
//   subnet_id           = module.virtual_network_ae.subnet_ids["vnet-avd-p02-ae"]["snet-avd-p04-ae"]
//   vm_count            = 0
//   // vm_count            = 2
//   vm_size             = var.vm_size
//   admin_username      = "avd-local-admin"
//   admin_password      = data.azurerm_key_vault_secret.admin_password.value
//   applicationgroupname  = var.applicationgroupname2
//   existing_workspace_id  = var.existing_workspace_id
//   aad_group_display_name = "gsg-prd-user-avdpersonalpawp03ae"
//   default_desktop_display_name = "Personal PAW Desktop"
//   key_vault_id        = data.azurerm_key_vault.keyvault.id # Pass Key Vault ID to module


//   providers = {
//      azurerm = azurerm.production
//    }
// }

// # ✅ Module Call Personal avd ae  rg-avd-p05-ae
// module "avd3" {
//   source              = "./modules/virtualdesktop"
//   host_pool_name      = var.host_pool_name3
//   friendly_name       = var.friendly_name3
//   vmhost_name         = var.vmhost_name3
//   location            = var.location
//   resource_group_name = module.rg_avd_p05_ae.name
//   subnet_id           = module.virtual_network_ae.subnet_ids["vnet-avd-p01-ae"]["snet-avd-p01-ae"]
//   vm_count            = 0
//   // vm_count            = 2
//   vm_size             = var.vm_size
//   admin_username      = "avd-local-admin"
//   admin_password      = data.azurerm_key_vault_secret.admin_password.value
//   applicationgroupname  = var.applicationgroupname3
//   existing_workspace_id  = var.existing_workspace_id
//   aad_group_display_name = "gsg-prd-user-avdpersonaldevp05ae"
//   default_desktop_display_name = "Personal Dev  Desktop"
//   key_vault_id        = data.azurerm_key_vault.keyvault.id # Pass Key Vault ID to module


//   providers = {
//      azurerm = azurerm.production
//    }
// }

// # ✅ Module Call Personal avd ae rg-avd-u01-ae
// module "avd_uat" {
//   source              = "./modules/virtualdesktop"
//   host_pool_name      = "vdpool-personal-u01-ae"
//   friendly_name       = "vdpool-personal-u01-ae"
//   vmhost_name         = "avdp-aeu1"
//   location            = var.location
//   resource_group_name = module.rg_avd_u01_ae.name
//   subnet_id           = module.virtual_network_ae.subnet_ids["vnet-avd-p01-ae"]["snet-avd-p01-ae"]
//   vm_count            = 0
//   // vm_count            = 2
//   vm_size             = var.vm_size
//   admin_username      = "avd-local-admin"
//   admin_password      = data.azurerm_key_vault_secret.admin_password.value
//   applicationgroupname  = "vdag-vdpool-personal-u01-ae"
//   existing_workspace_id  = var.existing_workspace_id
//   aad_group_display_name = "gsg-prd-user-avdpersonalu01ae"
//   default_desktop_display_name = "Personal UAT Desktop"
//   key_vault_id        = data.azurerm_key_vault.keyvault.id # Pass Key Vault ID to module

//   providers = {
//      azurerm = azurerm.production
//    }
// }

// # ✅ Module Call Shared avd ae  rg-avd-p04-ae
// module "shdavdae" {
//   source              = "./modules/Shareddesktop"
//   host_pool_name      = "vdpool-shared-app-p04-ae"
//   friendly_name       = "vdpool-shared-app-p04-ae"
//   vmhost_name         = var.vmhost_name4
//   location            = var.location
//   resource_group_name = module.rg_avd_p04_ae.name
//   subnet_id           = module.virtual_network_ae.subnet_ids["vnet-avd-p01-ae"]["snet-avd-p01-ae"]
//   vm_count            = 0
//   // vm_count            = 2
//   vm_size             = var.vm_size
//   admin_username      = "avd-local-admin"
//   admin_password      = data.azurerm_key_vault_secret.admin_password.value
//   applicationgroupname  = var.applicationgroupname4
//   existing_workspace_id  = var.existing_workspace_id
//   aad_group_display_name = "gsg-prd-user-avdsharedappp04ae"


//   providers = {
//      azurerm = azurerm.production
//    }
// }

// # ✅ Module Scaling Plan for australi East

// module "scaling_plan" {
//   source                = "./modules/scalingplan/personal"
//   scaling_name          = var.scaling_name
//   location              = var.location
//   resource_group_name   = module.rg_avd_p02_ae.name
//   enable_scaling_plan   = true

//   host_pool_ids = [
//     module.avd.host_pool_id,
//     module.avd2.host_pool_id,
//     module.avd3.host_pool_id,
//     module.avd_uat.host_pool_id,
//     // module.avd_p01_ae.host_pool_id
//   ]

//   providers = {
//     azapi = azapi
//   }

//    depends_on = [module.avd,module.avd2,module.avd3,module.avd_uat ]
// }


// module "pooled_scaling_plan" {
//   source              = "./modules/scalingplan/pooled"
//   scaling_name        = "sp-avd-p01-ae"
//   location            = var.location
//   resource_group_name = var.resource_group_name

//   host_pool_ids = [
//     module.shdavdae.host_pool_id
//   ]

//   providers = {
//      azurerm = azurerm.production
//   }
//  depends_on = [module.shdavdae ]
// }




// # ✅ Modules Call Shared avd ase

// # ✅ Module Call Shared avd ase  rg-avd-p01-ase

// module "generalase" {
//   source              = "./modules/vitualdesktop_ase"
//   host_pool_name      = "vdpool-personal-general-access-p01-ase"
//   friendly_name       = "vdpool-personal-general-access-p01-ase"
//   vmhost_name         = "avdp-asep1"
//   hp_location         =  var.location
//   location            = "Australia South East"
//   // hp_resource_group_name = data.azurerm_resource_group.existing_rg1.name
//   resource_group_name = module.rg_avd_p01_ase.name
//   subnet_id           = module.virtual_network.subnet_ids["vnet-avd-p01-ase"]["snet-avd-p01-ase"]
//   vm_count            = 0
//   // vm_count            = 1
//   vm_size             = var.vm_size
//   admin_username      = "avd-local-admin"
//   admin_password      = data.azurerm_key_vault_secret.admin_password.value
//   applicationgroupname  = "vdag-vdpool-personal-general-access-p01-ase"
//   aad_group_display_name = "gsg-prd-user-avdpersonalgeneralaccessp01ase"
//   create_workspace    = true
//   default_desktop_display_name = "DR Personal General Desktop"


//   providers = {
//      azurerm = azurerm.production
//    }
// }

// # ✅ Module Call Shared avd ase rg-avd-p02-ase
// module "vendorase" {
//   source              = "./modules/vitualdesktop_ase"
//   host_pool_name      = "vdpool-personal-vendor-p02-ase"
//   friendly_name       = "vdpool-personal-vendor-p02-ase"
//   vmhost_name         = "avdp-asep2"
//   hp_location         =  var.location
//   location            = "Australia South East"
//   // hp_resource_group_name = data.azurerm_resource_group.existing_rg.name
//   resource_group_name = module.rg_avd_p02_ase.name
//   subnet_id           = module.virtual_network.subnet_ids["vnet-avd-p01-ase"]["snet-avd-p02-ase"]
//   vm_count            = 0
//   // vm_count            = 1
//   vm_size             = var.vm_size
//   admin_username      = "avd-local-admin"
//   admin_password      = data.azurerm_key_vault_secret.admin_password.value
//   applicationgroupname  = "vdag-vdpool-personal-vendor-p02-ase"
//   aad_group_display_name = "gsg-prd-user-avdpersonalvendorp02ase"
//   create_workspace       = false
//   existing_workspace_id  = module.generalase.workspace_id
//   default_desktop_display_name = "DR Personal Vendor Desktop"


//   providers = {
//      azurerm = azurerm.production
//    }
//   depends_on = [module.generalase ]
// }

// # ✅ Module Call Shared avd ase rg-avd-p03-ase
// module "pawase" {
//   source              = "./modules/vitualdesktop_ase"
//   host_pool_name      = "vdpool-personal-paw-p03-ase"
//   friendly_name       = "vdpool-personal-paw-p03-ase"
//   vmhost_name         = "avdp-asep3"
//   hp_location         =  var.location
//   location            = "Australia South East"
//   resource_group_name = module.rg_avd_p03_ase.name
//   subnet_id           = module.virtual_network.subnet_ids["vnet-avd-p02-ase"]["snet-avd-p04-ase"]
//   vm_count            = 0
//   // vm_count            = 1
//   vm_size             = var.vm_size
//   admin_username      = "avd-local-admin"
//   admin_password      = data.azurerm_key_vault_secret.admin_password.value
//   applicationgroupname  = "vdag-vdpool-personal-paw-p03-ase"
//   aad_group_display_name = "gsg-prd-user-avdpersonalpawp03ase"
//   create_workspace       = false
//   existing_workspace_id  = module.generalase.workspace_id
//   default_desktop_display_name = "DR Personal PAW Desktop"


//   providers = {
//      azurerm = azurerm.production
//    }
//    depends_on = [module.generalase ]
// }

// # ✅ Module Call Shared avd ase rg-avd-p04-ase
// module "shdappase" {
//   source              = "./modules/Shareddesktop_ase"
//   host_pool_name      = "vdpool-shared-app-p04-ase"
//   friendly_name       = "vdpool-shared-app-p04-ase"
//   vmhost_name         = "avdp-asep4"
//   hp_location         =  var.location
//   location            = "Australia South East"
//   // hp_resource_group_name = data.azurerm_resource_group.existing_rg4.name
//   resource_group_name = module.rg_avd_p04_ase.name
//   subnet_id           = module.virtual_network.subnet_ids["vnet-avd-p01-ase"]["snet-avd-p01-ase"]
//   vm_count            = 0
//   // vm_count            = 1
//   vm_size             = var.vm_size
//   admin_username      = "avd-local-admin"
//   admin_password      = data.azurerm_key_vault_secret.admin_password.value
//   applicationgroupname  = "vrag-vdpool-shared-app-p04-ase"
//   aad_group_display_name = "gsg-prd-user-avdsharedappp04ase"
//   create_workspace       = false
//   existing_workspace_id  = module.generalase.workspace_id


//   providers = {
//      azurerm = azurerm.production
//    }
//    depends_on = [module.generalase ]
// }


// # ✅ Module Call Shared avd ase rg-avd-p05-ase
// module "devase" {
//   source              = "./modules/vitualdesktop_ase"
//   host_pool_name      = "vdpool-personal-dev-p05-ase"
//   friendly_name       = "vdpool-personal-dev-p05-ase"
//   vmhost_name         = "avdp-asep5"
//   hp_location         =  var.location
//   location            = "Australia South East"
//   // hp_resource_group_name = data.azurerm_resource_group.existing_rg3.name
//   resource_group_name = module.rg_avd_p05_ase.name
//   subnet_id           = module.virtual_network.subnet_ids["vnet-avd-p01-ase"]["snet-avd-p01-ase"]
//   vm_count            = 0
//   // vm_count            = 1
//   vm_size             = var.vm_size
//   admin_username      = "avd-local-admin"
//   admin_password      = data.azurerm_key_vault_secret.admin_password.value
//   applicationgroupname  = "vdag-vdpool-personal-dev-p05-ase"
//   aad_group_display_name = "gsg-prd-user-avdpersonaldevp05ase"
//   create_workspace       = false
//   existing_workspace_id  = module.generalase.workspace_id
//   default_desktop_display_name = "DR Personal Dev  Desktop"


//   providers = {
//      azurerm = azurerm.production
//    }
//    depends_on = [module.generalase ]
// }



// # ✅ Module Scaling Plan for australi south East

// module "scaling_plan_ase" {
//   source                = "./modules/scalingplan/personal"
//   scaling_name          = "sp-avd-personal-p01-ase"
//   location              = var.location
//   resource_group_name   = module.rg_avd_p01_ase.name
//   enable_scaling_plan   = true

//   host_pool_ids = [
//     module.generalase.host_pool_id,
//     module.vendorase.host_pool_id,
//     module.pawase.host_pool_id,
//     module.devase.host_pool_id
//   ]

//   providers = {
//     azapi = azapi
//   }

//    depends_on = [module.generalase,module.vendorase,module.pawase,module.devase ]
// }


// module "pooled_scaling_plan_ase" {
//   source              = "./modules/scalingplan/pooled"
//   scaling_name        = "sp-avd-p01-ase"
//   location            = var.location
//   resource_group_name = module.rg_avd_p04_ase.name

//   host_pool_ids = [
//     module.shdappase.host_pool_id
//   ]

//   providers = {
//      azurerm = azurerm.production
//   }
//  depends_on = [module.shdappase ]
// }