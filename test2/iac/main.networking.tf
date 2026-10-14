# Create virtual networks
module "virtual_networks" {
  for_each = local.vnet_data_map

  source  = "Azure/avm-res-network-virtualnetwork/azurerm"
  version = "0.8.1"

  resource_group_name = var.template_vars.resource_group_name
  location            = var.template_vars.location
  address_space       = ["10.1.0.0/16"] # Should this come from the config?
  name                = each.value.name

  tags = local.default_tags
}

# Create NSGs
module "network_security_groups" {
  for_each = local.network_security_group_data_map

  source              = "Azure/avm-res-network-networksecuritygroup/azurerm"
  version             = "0.4.0"
  resource_group_name = var.template_vars.resource_group_name
  location            = var.template_vars.location
  name                = each.value.name
  security_rules      = try(each.value.security_rules, {})
  enable_telemetry    = true

  tags = local.default_tags
}

# Create route tables
module "route_tables" {
  for_each = local.route_table_data_map

  source                        = "Azure/avm-res-network-routetable/azurerm"
  version                       = "0.4.1"
  location                      = var.template_vars.location
  name                          = each.value.name
  resource_group_name           = var.template_vars.resource_group_name
  bgp_route_propagation_enabled = each.value.bgp_route_propagation_enabled
  enable_telemetry              = true
  routes                        = try(each.value.routes, {})
  tags                          = try(each.value.tags, local.default_tags)
}

# Create subnets directly with the subnet module
module "subnets" {
  for_each = local.subnet_data_map

  source  = "Azure/avm-res-network-virtualnetwork/azurerm//modules/subnet"
  version = "0.8.1"

  name             = each.value.name
  address_prefixes = each.value.address_prefixes

  virtual_network = {
    resource_id = module.virtual_networks[each.value.vnet.key].resource_id
  }

  # Handle network_security_group - directly resolve key to ID if present
  network_security_group = try(
    each.value.network_security_group.key != null ?
    { id = module.network_security_groups[each.value.network_security_group.key].resource_id } :
    each.value.network_security_group.id != null ?
    { id = each.value.network_security_group.id } :
    null,
    {}
  )

  # Handle route_table - directly resolve key to ID if present
  route_table = try(
    each.value.route_table.key != null ?
    { id = module.route_tables[each.value.route_table.key].resource_id } :
    each.value.route_table.id != null ?
    { id = each.value.route_table.id } :
    null,
    {}
  )

  # Add standard subnet properties
  default_outbound_access_enabled               = try(each.value.default_outbound_access_enabled, false)
  private_endpoint_network_policies             = try(each.value.private_endpoint_network_policies, "Enabled")
  private_link_service_network_policies_enabled = try(each.value.private_link_service_network_policies_enabled, true)
  delegation                                    = try(each.value.delegation, null)
  nat_gateway                                   = try(each.value.nat_gateway, null)
  service_endpoint_policies                     = try(each.value.service_endpoint_policies, null)
  service_endpoints                             = try(each.value.service_endpoints, null)
  role_assignments                              = try(each.value.role_assignments, {})

  depends_on = [
    module.network_security_groups,
    module.route_tables,
    module.virtual_networks
  ]
}
