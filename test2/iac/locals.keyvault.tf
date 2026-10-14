locals {
  key_vault_data_map = merge([
    for key, value in local.config_map :
    {
      for kv_key, kv_value in try(value.key_vaults, {}) :
      kv_key => kv_value
      if !try(kv_value.use_existing, false) && !contains(keys(kv_value), "id")
    }
    if contains(keys(value), "key_vaults")
  ]...)

  key_vault_reference_map = merge([
    for key, value in local.config_map :
    {
      for kv_key, kv_value in try(value.key_vaults, {}) :
      kv_key => {
        id                  = try(kv_value.id, null)
        name                = try(kv_value.name, null)
        resource_group_name = try(kv_value.resource_group_name, null)
      }
      if try(kv_value.use_existing, true) || contains(keys(kv_value), "id")
    }
    if contains(keys(value), "key_vaults")
  ]...)

  key_vault_outputs = merge(
    {
      for k, v in local.key_vault_reference_map :
      k => (
        v.id != null ?
        v.id :
        "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${v.resource_group_name}/providers/Microsoft.key_vault/vaults/${v.name}"
      )
    },
    {
      for k, v in module.key_vault :
      k => v.resource_id
    }
  )
}
