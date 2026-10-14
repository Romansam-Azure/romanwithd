# Virtual Network Module AE
module "virtual_network_ae" {
  source              = "./modules/virtual_network"
  resource_group_name = "rg-avd-networking-p01-ae"
  location            = "australiaeast"
  common_tags         = local.common_vnet_tags_ae
  nsg_ids             = module.network_security_group_ae.nsg_ids
  route_table_ids     = module.route_table_ae.route_table_ids
  virtual_networks    = {
    "vnet-avd-p01-ae" = {
      address_space      = ["10.246.64.0/23"]
      dns_servers        = ["10.246.1.4"]
      encryption_enabled = true
      subnets = [
        {
          name                                 = "snet-avd-p01-ae"
          address_prefixes                     = ["10.246.64.0/24"]
          nsg_name                             = "nsg-avd-p01-ae"
          route_table_name                     = "udr-avd-p01-ae"
          private_endpoint_network_policies_enabled = false
          private_link_service_network_policies_enabled = true
          service_endpoints                    = ["Microsoft.KeyVault", "Microsoft.Storage"]
        },
        {
          name                                 = "snet-avd-p02-ae"
          address_prefixes                     = ["10.246.65.0/25"]
          nsg_name                             = "nsg-avd-p02-ae"
          route_table_name                     = "udr-avd-p01-ae"
          private_endpoint_network_policies_enabled = false
          private_link_service_network_policies_enabled = true
          service_endpoints                    = ["Microsoft.KeyVault", "Microsoft.Storage"]
        },
        {
          name                                 = "snet-avd-p03-ae"
          address_prefixes                     = ["10.246.65.144/28"]
          nsg_name                             = "nsg-avd-p03-ae"
          route_table_name                     = "udr-avd-p01-ae"
          private_endpoint_network_policies_enabled = false
          private_link_service_network_policies_enabled = true
          service_endpoints                    = ["Microsoft.KeyVault", "Microsoft.Storage"]
        },
        {
          name                                 = "snet-avd-endpoint-p01-ae"
          address_prefixes                     = ["10.246.65.128/28"]
          nsg_name                             = "nsg-avd-endpoint-p01-ae"
          route_table_name                     = "udr-avd-p01-ae"
          private_endpoint_network_policies_enabled = true
          private_link_service_network_policies_enabled = true
          service_endpoints                    = ["Microsoft.KeyVault", "Microsoft.Storage"]
        },
        {
          name                                 = "AzureBastionSubnet"
          address_prefixes                     = ["10.246.65.192/26"]
          nsg_name                             = ""
          route_table_name                     = ""
          private_endpoint_network_policies_enabled = false
          private_link_service_network_policies_enabled = true
          service_endpoints                    = ["Microsoft.KeyVault", "Microsoft.Storage"]
        }
      ]
    },
    "vnet-avd-p02-ae" = {
      address_space      = ["10.246.66.0/23"]
      dns_servers        = ["10.246.1.4"]
      encryption_enabled = true
      subnets = [
        {
          name                                 = "snet-avd-p04-ae"
          address_prefixes                     = ["10.246.66.0/24"]
          nsg_name                             = "nsg-avd-p04-ae"
          route_table_name                     = "udr-avd-p02-ae"
          private_endpoint_network_policies_enabled = false
          private_link_service_network_policies_enabled = true
          service_endpoints                    = ["Microsoft.KeyVault", "Microsoft.Storage"]
        },
        {
          name                                 = "snet-avd-endpoint-p02-ae"
          address_prefixes                     = ["10.246.67.0/24"]
          nsg_name                             = "nsg-avd-endpoint-p02-ae"
          route_table_name                     = "udr-avd-p02-ae"
          private_endpoint_network_policies_enabled = true
          private_link_service_network_policies_enabled = true
          service_endpoints                    = ["Microsoft.KeyVault", "Microsoft.Storage"]
        }
      ]
    }
  }
  virtual_network_peerings = {
    "vnet-avd-p01-ae" = {
      name                      = "avd-hub-p01-ae"
      remote_virtual_network_id = "/subscriptions/e2e6fc44-f2c5-498f-94c5-c4d271ed21ae/resourceGroups/rg-hub-networking-p01-ae/providers/Microsoft.Network/virtualNetworks/vnet-hub-p01-ae"
    },
    "vnet-avd-p02-ae" = {
      name                      = "avd-hub-p02-ae"
      remote_virtual_network_id = "/subscriptions/e2e6fc44-f2c5-498f-94c5-c4d271ed21ae/resourceGroups/rg-hub-networking-p01-ae/providers/Microsoft.Network/virtualNetworks/vnet-hub-p01-ae"
    }
  }
}

# Virtual Network Module ASE
module "virtual_network" {
  source              = "./modules/virtual_network"
  resource_group_name = "rg-avd-networking-p01-ase"
  location            = "australiasoutheast"
  common_tags         = local.common_vnet_tags
  nsg_ids             = module.network_security_group.nsg_ids
  route_table_ids     = module.route_table.route_table_ids
  virtual_networks    = {
    "vnet-avd-p01-ase" = {
      address_space      = ["10.247.64.0/23"]
      dns_servers        = ["10.247.1.4"]
      encryption_enabled = true
      subnets = [
        {
          name                                 = "snet-avd-p01-ase"
          address_prefixes                     = ["10.247.64.0/24"]
          nsg_name                             = "nsg-avd-p01-ase"
          route_table_name                     = "udr-avd-p01-ase"
          private_endpoint_network_policies_enabled = false
          private_link_service_network_policies_enabled = true
          service_endpoints                    = ["Microsoft.KeyVault", "Microsoft.Storage"]
        },
        {
          name                                 = "snet-avd-p02-ase"
          address_prefixes                     = ["10.247.65.0/25"]
          nsg_name                             = "nsg-avd-p02-ase"
          route_table_name                     = "udr-avd-p01-ase"
          private_endpoint_network_policies_enabled = false
          private_link_service_network_policies_enabled = true
          service_endpoints                    = ["Microsoft.KeyVault", "Microsoft.Storage"]
        },
        {
          name                                 = "snet-avd-p03-ase"
          address_prefixes                     = ["10.247.65.144/28"]
          nsg_name                             = "nsg-avd-p03-ase"
          route_table_name                     = "udr-avd-p01-ase"
          private_endpoint_network_policies_enabled = false
          private_link_service_network_policies_enabled = true
          service_endpoints                    = ["Microsoft.KeyVault", "Microsoft.Storage"]
        },
        {
          name                                 = "snet-avd-endpoint-p01-ase"
          address_prefixes                     = ["10.247.65.128/28"]
          nsg_name                             = "nsg-avd-endpoint-p01-ase"
          route_table_name                     = "udr-avd-p01-ase"
          private_endpoint_network_policies_enabled = true
          private_link_service_network_policies_enabled = true
          service_endpoints                    = ["Microsoft.KeyVault", "Microsoft.Storage"]
        }
      ]
    },
    "vnet-avd-p02-ase" = {
      address_space      = ["10.247.66.0/23"]
      dns_servers        = ["10.247.1.4"]
      encryption_enabled = true
      subnets = [
        {
          name                                 = "snet-avd-p04-ase"
          address_prefixes                     = ["10.247.66.0/24"]
          nsg_name                             = "nsg-avd-p04-ase"
          route_table_name                     = "udr-avd-p02-ase"
          private_endpoint_network_policies_enabled = false
          private_link_service_network_policies_enabled = true
          service_endpoints                    = ["Microsoft.KeyVault", "Microsoft.Storage"]
        },
        {
          name                                 = "snet-avd-endpoint-p02-ase"
          address_prefixes                     = ["10.247.67.0/24"]
          nsg_name                             = "nsg-avd-endpoint-p02-ase"
          route_table_name                     = "udr-avd-p02-ase"
          private_endpoint_network_policies_enabled = true
          private_link_service_network_policies_enabled = true
          service_endpoints                    = ["Microsoft.KeyVault", "Microsoft.Storage"]
        }
      ]
    }
  }
  virtual_network_peerings = {
    "vnet-avd-p01-ase" = {
      name                      = "avd-hub-p01-ase"
      remote_virtual_network_id = "/subscriptions/e2e6fc44-f2c5-498f-94c5-c4d271ed21ae/resourceGroups/rg-hub-networking-p01-ase/providers/Microsoft.Network/virtualNetworks/vnet-hub-p01-ase"
    },
    "vnet-avd-p02-ase" = {
      name                      = "avd-hub-p02-ase"
      remote_virtual_network_id = "/subscriptions/e2e6fc44-f2c5-498f-94c5-c4d271ed21ae/resourceGroups/rg-hub-networking-p01-ase/providers/Microsoft.Network/virtualNetworks/vnet-hub-p01-ase"
    }
  }
}