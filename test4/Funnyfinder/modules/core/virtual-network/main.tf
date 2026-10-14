locals {
  address_space = {
    development = {
      vnet             = "10.1.0.0/16"
      peSubnet         = "10.1.1.0/24"
      appSubnet        = "10.1.2.0/24"
      keyVaultSubnet   = "10.1.3.0/24"
      storageSubnet    = "10.1.4.0/24"
      postgreSqlSubnet = "10.1.5.0/24"
      apimSubnet       = "10.1.6.0/24"
    }
    test = {
      vnet             = "10.2.0.0/16"
      peSubnet         = "10.2.1.0/24"
      appSubnet        = "10.2.2.0/24"
      keyVaultSubnet   = "10.2.3.0/24"
      storageSubnet    = "10.2.4.0/24"
      postgreSqlSubnet = "10.2.5.0/24"
      apimSubnet       = "10.2.6.0/24"
    }
    production = {
      vnet             = "10.3.0.0/16"
      peSubnet         = "10.3.1.0/24"
      appSubnet        = "10.3.2.0/24"
      keyVaultSubnet   = "10.3.3.0/24"
      storageSubnet    = "10.3.4.0/24"
      postgreSqlSubnet = "10.3.5.0/24"
      apimSubnet       = "10.3.6.0/24"
    }
  }

  cidr = local.address_space[var.environment_name]
}

resource "azurerm_virtual_network" "this" {
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = [local.cidr.vnet]
  tags                = var.tags

  subnet {
    name             = "private-endpoints-subnet"
    address_prefixes = [local.cidr.peSubnet]
    private_endpoint_network_policies = "Disabled"
  }

  subnet {
    name             = "app"
    address_prefixes = [local.cidr.appSubnet]
    private_endpoint_network_policies = "Disabled"
    delegation {
      name = "Microsoft.App/environments"
      service_delegation {
        name = "Microsoft.App/environments"
      }
    }
  }

  subnet {
    name             = "keyvault-subnet"
    address_prefixes = [local.cidr.keyVaultSubnet]
    private_endpoint_network_policies = "Disabled"
  }

  subnet {
    name             = "storage-subnet"
    address_prefixes = [local.cidr.storageSubnet]
    private_endpoint_network_policies = "Disabled"
  }

  subnet {
    name             = "postgresql-subnet"
    address_prefixes = [local.cidr.postgreSqlSubnet]
    private_endpoint_network_policies = "Disabled"
    delegation {
      name = "PostgreSQLDelegation"
      service_delegation {
        name = "Microsoft.DBforPostgreSQL/flexibleServers"
      }
    }
  }

  subnet {
    name             = "apim-subnet"
    address_prefixes = [local.cidr.apimSubnet]
    private_endpoint_network_policies = "Disabled"
    delegation {
      name = "APIMDelegation"
      service_delegation {
        name = "Microsoft.ApiManagement/service"
      }
    }
  }
}