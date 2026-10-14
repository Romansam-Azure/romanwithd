locals {
  # Expand pattern-based virtual machine sets into individual VMs
  vm_data_map = merge(flatten([
    for key, value in local.config_map : [
      for vm_set_key, vm_set in try(value.virtual_machines, {}) : [
        for i in range(0, try(vm_set.vm_count, 0)) : {
          "${vm_set_key}_${i + try(vm_set.vm_count_start, 1)}" = merge(
            vm_set,
            {
              name       = format(vm_set.vm_name_pattern, i + try(vm_set.vm_count_start, 1))
              index      = i + try(vm_set.vm_count_start, 1)
              ip_address = format(vm_set.ip_format, i + try(vm_set.ip_start, 0))
            }
          )
        }
      ]
    ] if contains(keys(value), "virtual_machines")
  ])...)

  # Filtered list of Windows VMs
  win_vm_list = {
    for k, v in local.vm_data_map :
    k => v if try(v.os_type, "Linux") == "Windows"
  }

  # Filtered list of Linux VMs
  linux_vm_list = {
    for k, v in local.vm_data_map :
    k => v if try(v.os_type, "Linux") == "Linux"
  }

  # Key Vault configuration per VM (if any)
  vm_key_vault_reference_map = {
    for vm_key, vm in local.vm_data_map :
    vm_key => (
      try(vm.account_credentials.key_vault_configuration, null) == null
      ? null
      : {
          resource_id = coalesce(
            try(local.key_vault_outputs[vm.account_credentials.key_vault_configuration.key_vault.key], null),
            try(vm.account_credentials.key_vault_configuration.key_vault.id, null)
          )
          secret_configuration = merge(
            { name = try(vm.account_credentials.key_vault_configuration.secret_configuration.name, "") },
            try(vm.account_credentials.key_vault_configuration.secret_configuration, {})
          )
        }
    )
    if try(vm.account_credentials.key_vault_configuration, null) != null
  }

  # Flattened NIC + IP config map with fallback names and subnet resolution
  vm_network_interfaces_map = {
    for vm_key, vm in local.vm_data_map :
    vm_key => {
      for nic_key, nic in try(vm.network_interfaces, {}) :
      nic_key => merge(
        nic,
        {
          name       = try(nic.name, "nic-${nic_key}-${vm_key}")
          is_primary = try(nic.is_primary, nic_key == "nic1")

          ip_configurations = {
            for ip_key, ipconf in try(nic.ip_configurations, {}) :
            ip_key => merge(
              ipconf,
              {
                name = try(ipconf.name, ip_key)
                private_ip_subnet_resource_id = (
                  try(ipconf.private_ip_subnet_resource_id, null) != null
                  ? ipconf.private_ip_subnet_resource_id
                  : try(local.subnet_outputs[try(ipconf.subnet.key, "")], try(ipconf.subnet.id, null))
                )
              }
            )
          }
        }
      )
    }
  }

  # Normalized account credential structures with fallback for password authentication
  account_credentials_map = {
    for vm_key, vm in local.vm_data_map :
    vm_key => (
      try(vm.account_credentials, null) == null ? null : {
        admin_credentials = try(vm.account_credentials.admin_credentials, null)
        ssh_key           = try(vm.account_credentials.ssh_key, null)

        password_authentication_disabled = (
          try(vm.os_type, "Linux") == "Windows"
          ? true
          : try(vm.account_credentials.password_authentication_disabled, false)
        )

        key_vault_configuration = (
          try(vm.account_credentials.key_vault_configuration, null) == null
          ? null
          : {
              resource_id = (
                try(vm.account_credentials.key_vault_configuration.key_vault.key, null) != null
                ? try(local.key_vault_outputs[vm.account_credentials.key_vault_configuration.key_vault.key], null)
                : try(vm.account_credentials.key_vault_configuration.key_vault.id, null)
              )
              secret_configuration = try(vm.account_credentials.key_vault_configuration.secret_configuration, null)
            }
        )
      }
    )
  }

  # Output-friendly map with fallback for name
  vm_outputs = {
    for k, v in local.vm_data_map :
    k => {
      name        = try(v.name, k)
      resource_id = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${v.resource_group_name}/providers/Microsoft.Compute/virtualMachines/${try(v.name, k)}"
    }
  }

  # ✅ Domain join map for Windows VMs
  vm_domain_join_map = {
    for vm_key, vm in local.vm_data_map :
    vm_key => (
      try(vm.domain_join, null) == null ? null : {
        domain_name     = vm.domain_join.domain_name
        domain_username = vm.domain_join.domain_user
        domain_password = try(
          data.azurerm_key_vault_secret.domain_join_passwords[vm_key].value,
          null
        )
        join_ou         = try(vm.domain_join.ou_path, null)
      }
    )
    if try(vm.domain_join, null) != null
  }
}