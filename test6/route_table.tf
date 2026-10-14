# Route Table Module AE
module "route_table_ae" {
  source              = "./modules/route_table"
  resource_group_name = "rg-avd-networking-p01-ae"
  location            = "australiaeast"
  common_tags         = local.common_vnet_tags_ae
  route_tables        = {
    "udr-avd-p01-ae" = {
      routes = [
        {
          name                   = "default-route"
          address_prefix         = "0.0.0.0/0"
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = "10.246.0.132"
        },
        {
          name            = "AVD"
          address_prefix  = "WindowsVirtualDesktop"
          next_hop_type   = "Internet"
        }
      ]
    },
    "udr-avd-p02-ae" = {
      routes = [
        {
          name                   = "default-route"
          address_prefix         = "0.0.0.0/0"
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = "10.246.0.132"
        },
        {
          name            = "AVD"
          address_prefix  = "WindowsVirtualDesktop"
          next_hop_type   = "Internet"
        }
      ]
    }
  }
}


# Route Table Module ASE
module "route_table" {
  source              = "./modules/route_table"
  resource_group_name = "rg-avd-networking-p01-ase"
  location            = "australiasoutheast"
  common_tags         = local.common_vnet_tags
  route_tables        = {
    "udr-avd-p01-ase" = {
      routes = [
        {
          name                   = "default-route"
          address_prefix         = "0.0.0.0/0"
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = "10.247.0.132"
        },
        {
          name            = "AVD"
          address_prefix  = "WindowsVirtualDesktop"
          next_hop_type   = "Internet"
        }
      ]
    },
    "udr-avd-p02-ase" = {
      routes = [
        {
          name                   = "default-route"
          address_prefix         = "0.0.0.0/0"
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = "10.247.0.132"
        },
        {
          name            = "AVD"
          address_prefix  = "WindowsVirtualDesktop"
          next_hop_type   = "Internet"
        }
      ]
    }
  }
}