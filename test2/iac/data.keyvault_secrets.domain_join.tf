data "azurerm_key_vault_secret" "domain_join_passwords" {
  for_each = {
    for vm_key, vm in local.vm_data_map :
    vm_key => {
      key_vault_key = vm.domain_join.domain_password_secret.key_vault.key
      secret_name   = vm.domain_join.domain_password_secret.secret_configuration.name
    }
    if try(vm.domain_join.domain_password_secret, null) != null
  }

  name         = each.value.secret_name
  key_vault_id = local.key_vault_outputs[each.value.key_vault_key]
}