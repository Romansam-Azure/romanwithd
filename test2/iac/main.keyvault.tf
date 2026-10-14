module "key_vault" {
  for_each = local.key_vault_data_map

  source  = "Azure/avm-res-keyvault-vault/azurerm"
  version = "0.10.0"

  resource_group_name = var.template_vars.resource_group_name
  location            = var.template_vars.location
  name                = each.value.name
  tenant_id           = data.azurerm_client_config.current.tenant_id

  # optional
  contacts                        = try(each.value.contacts, {})
  enabled_for_deployment          = try(each.value.enabled_for_deployment, null)
  enabled_for_disk_encryption     = try(each.value.enabled_for_disk_encryption, null)
  enabled_for_template_deployment = try(each.value.enabled_for_template_deployment, null)
  legacy_access_policies_enabled  = false
  network_acls                    = try(each.value.network_acls, null)
  public_network_access_enabled   = try(each.value.public_network_access_enabled, null)
  purge_protection_enabled        = try(each.value.purge_protection_enabled, null)
  sku_name                        = try(each.value.sku_name, "standard")
  soft_delete_retention_days      = try(each.value.soft_delete_retention_days, null)

  # child resources
  keys          = try(each.value.keys, null)
  secrets       = try(each.value.secrets, null)
  secrets_value = try(each.value.secrets_value, null)

  # standard interfaces
  diagnostic_settings = try(each.value.diagnostic_settings, null)
  lock                = try(each.value.lock, null)
  role_assignments    = try(each.value.role_assignments, null)
  tags                = try(each.value.tags, local.default_tags)

  private_endpoints = {
    for pe_key, pe in try(each.value.private_endpoints, []) : pe_key => {
      private_dns_zone_resource_ids = try(pe.private_dns_zone_resource_ids, null)
      subnet = (
        try(pe.subnet.key, null) != null ?
        { id = local.subnet_outputs[pe.subnet.key] } :
        try(pe.subnet.id, null) != null ?
        { id = pe.subnet.id } :
        null
      )
    }
  }

  enable_telemetry = true
}
