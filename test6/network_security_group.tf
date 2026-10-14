# Network Security Group Module AE
module "network_security_group_ae" {
  source              = "./modules/network_security_group"
  resource_group_name = "rg-avd-networking-p01-ae"
  location            = "australiaeast"
  common_tags         = local.common_vnet_tags_ae
  network_security_groups = {
    "nsg-avd-p01-ae" = {
      rules = [
        {
          name                       = "Allow_UDP_3390_RDP_Shortpath"
          priority                   = 100
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Udp"
          source_port_range          = "*"
          destination_port_range     = "3390"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        }
      ]
    },
    "nsg-avd-p02-ae" = {
      rules = [
        {
          name                       = "Allow_UDP_3390_RDP_Shortpath"
          priority                   = 100
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Udp"
          source_port_range          = "*"
          destination_port_range     = "3390"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        }
      ]
    },
    "nsg-avd-p03-ae" = {
      rules = [
        {
          name                       = "Allow_UDP_3390_RDP_Shortpath"
          priority                   = 100
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Udp"
          source_port_range          = "*"
          destination_port_range     = "3390"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        }
      ]
    },
    "nsg-avd-p04-ae" = {
      rules = [
        {
          name                       = "Allow_UDP_3390_RDP_Shortpath"
          priority                   = 100
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Udp"
          source_port_range          = "*"
          destination_port_range     = "3390"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        }
      ]
    },
    # Default rules only — no custom rules required
    "nsg-avd-endpoint-p01-ae" = {
      rules = []
    },
    "nsg-avd-endpoint-p02-ae" = {
      rules = []
    }
  }
}


# Network Security Group Module ASE
module "network_security_group" {
  source              = "./modules/network_security_group"
  resource_group_name = "rg-avd-networking-p01-ase"
  location            = "australiasoutheast"
  common_tags         = local.common_vnet_tags

  network_security_groups = {
    "nsg-avd-p01-ase" = {
      rules = [
        {
          name                       = "Allow_UDP_3390_RDP_Shortpath"
          priority                   = 100
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Udp"
          source_port_range          = "*"
          destination_port_range     = "3390"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        }
      ]
    },
    "nsg-avd-p02-ase" = {
      rules = [
        {
          name                       = "Allow_UDP_3390_RDP_Shortpath"
          priority                   = 100
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Udp"
          source_port_range          = "*"
          destination_port_range     = "3390"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        }
      ]
    },
    "nsg-avd-p03-ase" = {
      rules = [
        {
          name                       = "Allow_UDP_3390_RDP_Shortpath"
          priority                   = 100
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Udp"
          source_port_range          = "*"
          destination_port_range     = "3390"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        }
      ]
    },
    "nsg-avd-p04-ase" = {
      rules = [
        {
          name                       = "Allow_UDP_3390_RDP_Shortpath"
          priority                   = 100
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Udp"
          source_port_range          = "*"
          destination_port_range     = "3390"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        }
      ]
    },
    # Default rules only — no custom rules required
    "nsg-avd-endpoint-p01-ase" = {
      rules = []
    },
    "nsg-avd-endpoint-p02-ase" = {
      rules = []
    }
  }
}
