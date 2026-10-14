locals {
  vnet_data_map = merge([
    for key, value in local.config_map :
    {
      for vnet_key, vnet_value in try(value.virtual_networks, {}) :
      vnet_key => vnet_value
      if !try(vnet_value.use_existing, false) && !contains(keys(vnet_value), "id")
    }
    if contains(keys(value), "virtual_networks")
  ]...)

  vnet_reference_map = merge([
    for key, value in local.config_map :
    {
      for vnet_key, vnet_value in try(value.virtual_networks, {}) :
      vnet_key => {
        id                  = try(vnet_value.id, null)
        name                = try(vnet_value.name, null)
        resource_group_name = try(vnet_value.resource_group_name, null)
      }
      if try(vnet_value.use_existing, true) || contains(keys(vnet_value), "id")
    }
    if contains(keys(value), "virtual_networks")
  ]...)

  vnet_outputs = merge(
    {
      for k, v in local.vnet_reference_map :
      k => (
        v.id != null ?
        v.id :
        "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${v.resource_group_name}/providers/Microsoft.Network/virtualNetworks/${v.name}"
      )
    },
    {
      for k, v in module.virtual_networks :
      k => v.resource_id
    }
  )

  route_table_data_map = merge([
    for key, value in local.config_map :
    {
      for rt_key, rt_value in try(value.route_tables, {}) :
      rt_key => rt_value
    }
    if contains(keys(value), "route_tables")
  ]...)

  network_security_group_data_map = merge([
    for key, value in local.config_map :
    {
      for nsg_key, nsg_value in try(value.network_security_groups, {}) :
      nsg_key => nsg_value
    }
    if contains(keys(value), "network_security_groups")
  ]...)

  subnet_data_map = merge([
    for key, value in local.config_map :
    {
      for subnet_key, subnet_value in try(value.subnets, {}) :
      subnet_key => merge(
        subnet_value,
        {
          # id       = subnet_key
          # vnet_key = subnet_value.vnet.key

          # Expand NSG/route_table keys to full embedded objects
          network_security_group = merge(
            try({ key = subnet_value.network_security_group.key }, {}),
            try({ id = subnet_value.network_security_group.id }, {}),
            try(local.network_security_group_data_map[subnet_value.network_security_group.key], {})
          ),
          route_table = merge(
            try({ key = subnet_value.route_table.key }, {}),
            try({ id = subnet_value.route_table.id }, {}),
            try(local.route_table_data_map[subnet_value.route_table.key], {})
          )
        }
      )
    }
    if contains(keys(value), "subnets")
  ]...)

  subnet_outputs = {
    for k, v in module.subnets :
    k => v.resource_id
  }

}
