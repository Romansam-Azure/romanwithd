# Virtual Networks
resource "azurerm_virtual_network" "vnet" {
  for_each            = var.virtual_networks
  name                = each.key
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = each.value.address_space
  tags                = merge(var.common_tags, { "Object.ResourceType" = "vnet" })

  dns_servers = each.value.dns_servers

  dynamic "encryption" {
    for_each = each.value.encryption_enabled ? [1] : []
    content {
      enforcement = "AllowUnencrypted"
    }
  }
}

# Subnets
resource "azurerm_subnet" "subnet" {
  for_each             = { for subnet in local.subnets : "${subnet.vnet_name}.${subnet.name}" => subnet }
  name                 = each.value.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet[each.value.vnet_name].name
  address_prefixes     = each.value.address_prefixes

  private_endpoint_network_policies_enabled     = each.value.private_endpoint_network_policies_enabled
  private_link_service_network_policies_enabled = each.value.private_link_service_network_policies_enabled

  service_endpoints = each.value.service_endpoints

  depends_on = [azurerm_virtual_network.vnet]
}

# Subnet NSG Associations
resource "azurerm_subnet_network_security_group_association" "subnet_nsg" {
  for_each                  = { for subnet in local.subnets : "${subnet.vnet_name}.${subnet.name}" => subnet if subnet.nsg_name != "" }
  subnet_id                 = azurerm_subnet.subnet["${each.value.vnet_name}.${each.value.name}"].id
  network_security_group_id = var.nsg_ids[each.value.nsg_name]

}

//  # Subnet NSG Associations
// resource "azurerm_subnet_network_security_group_association" "subnet_nsg" {
//   for_each = {
//     for subnet in local.subnets :
//     "${subnet.vnet_name}.${subnet.name}" => subnet
//     if subnet.nsg_name != "" && contains(keys(var.nsg_ids), subnet.nsg_name)
//   }

//   subnet_id                 = azurerm_subnet.subnet["${each.value.vnet_name}.${each.value.name}"].id
//   network_security_group_id = var.nsg_ids[each.value.nsg_name]
// }


# Subnet Route Table Associations
resource "azurerm_subnet_route_table_association" "subnet_route" {
  for_each       = { for subnet in local.subnets : "${subnet.vnet_name}.${subnet.name}" => subnet if subnet.route_table_name != "" }
  subnet_id      = azurerm_subnet.subnet["${each.value.vnet_name}.${each.value.name}"].id
  route_table_id = var.route_table_ids[each.value.route_table_name]
}

# Virtual Network Peerings
resource "azurerm_virtual_network_peering" "peering" {
  for_each                  = var.virtual_network_peerings
  name                      = each.value.name
  resource_group_name       = var.resource_group_name
  virtual_network_name      = azurerm_virtual_network.vnet[each.key].name
  remote_virtual_network_id = each.value.remote_virtual_network_id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
  use_remote_gateways          = true

  depends_on = [azurerm_virtual_network.vnet]
}

# Local variable to flatten subnets
locals {
  subnets = flatten([
    for vnet_name, vnet in var.virtual_networks : [
      for subnet in vnet.subnets : {
        vnet_name                            = vnet_name
        name                                 = subnet.name
        address_prefixes                     = subnet.address_prefixes
        nsg_name                             = subnet.nsg_name
        route_table_name                     = subnet.route_table_name
        private_endpoint_network_policies_enabled = subnet.private_endpoint_network_policies_enabled
        private_link_service_network_policies_enabled = subnet.private_link_service_network_policies_enabled
        service_endpoints                    = subnet.service_endpoints
      }
    ]
  ])
}