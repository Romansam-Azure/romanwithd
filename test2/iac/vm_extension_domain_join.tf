locals {
  # non-sensitive keys for VMs needing domain join
  vm_domain_join_keys = [
    for vm_key, vm in local.vm_data_map :
    vm_key if try(vm.domain_join, null) != null
  ]
}

resource "azurerm_virtual_machine_extension" "domain_join" {
  for_each = toset(local.vm_domain_join_keys)

  name               = "joindomain-${each.key}"
  virtual_machine_id = local.vm_outputs[each.key].resource_id
  publisher          = "Microsoft.Compute"
  type               = "JsonADDomainExtension"
  type_handler_version = "1.3"

  settings = jsonencode({
    Name    = local.vm_data_map[each.key].domain_join.domain_name
    User    = local.vm_data_map[each.key].domain_join.domain_user
    Restart = "true"
    Options = 3
    OUPath  = try(local.vm_data_map[each.key].domain_join.ou_path, null)
  })

  protected_settings = jsonencode({
    Password = data.azurerm_key_vault_secret.domain_join_passwords[each.key].value
  })

  depends_on = [module.vm_windows]
}