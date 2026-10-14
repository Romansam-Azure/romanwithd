terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

# Azure Local Network Gateway
resource "azurerm_local_network_gateway" "onpremise" {
  name                = var.local_gateway_name
  location            = var.location
  resource_group_name = var.resource_group_name
  gateway_address     = var.gateway_address
  address_space       = var.address_space
  bgp_settings        {
    asn                 = "65107"
    bgp_peering_address = "169.254.21.2"
  }

}

# Azure Local Network Gateway
resource "azurerm_local_network_gateway" "onpremise2" {
  name                = var.local_gateway_name2
  location            = var.location
  resource_group_name = var.resource_group_name
  gateway_address     = var.gateway_address2
  address_space       = var.address_space2
  bgp_settings        {
    asn                 = "65107"
    bgp_peering_address = "169.254.21.2"
  }
}

# Azure Virtual Network Gateway
resource "azurerm_virtual_network_gateway" "vpngw" {
  name                = var.vpn_gateway_name
  location            = var.location
  resource_group_name = var.resource_group_name
  type                = var.gateway_type
  vpn_type            = var.vpn_type
  sku                 = var.vpn_gw_sku
  active_active       = var.enable_active_active
  enable_bgp          = var.enable_bgp
  

  ip_configuration {
    name                          = var.ip_configuration
    private_ip_address_allocation = var.private_ip_address_allocation
    subnet_id                     = var.subnet_id
    public_ip_address_id          = var.public_ip_address_id
  }
}
#S2S Configuration

resource "azurerm_virtual_network_gateway_connection" "onpremisec" {
  name                = var.local_gateway_connection_name
  location            = var.location
  resource_group_name = var.resource_group_name

  type                       = "IPsec"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.vpngw.id
  local_network_gateway_id   = azurerm_local_network_gateway.onpremise.id

  shared_key = "4-v3ry-53cr37-1p53c-5h4r3d-k3y"
}


resource "azurerm_virtual_network_gateway_connection" "onpremisec2" {
  name                = var.local_gateway_connection_name2
  location            = var.location
  resource_group_name = var.resource_group_name

  type                       = "IPsec"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.vpngw.id
  local_network_gateway_id   = azurerm_local_network_gateway.onpremise2.id

  shared_key = "4-v3ry-53cr37-1p53c-5h4r3d-k3y"
}