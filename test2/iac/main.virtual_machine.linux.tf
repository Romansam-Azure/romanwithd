module "vm_linux" {
  for_each = local.linux_vm_list

  source  = "Azure/avm-res-compute-virtualmachine/azurerm"
  version = "0.19.1"

  location            = each.value.location
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  sku_size            = each.value.sku_size
  zone                = try(each.value.zone, "1")
  os_type             = "Linux"
  network_interfaces  = local.vm_network_interfaces_map[each.key]

  account_credentials                       = local.account_credentials_map[each.key]
  generated_secrets_key_vault_secret_config = try(local.vm_key_vault_reference_map[each.key], null)

  computer_name = try(each.value.computer_name, null)
  os_disk       = each.value.os_disk

  boot_diagnostics = true

  allow_extension_operations                             = try(each.value.allow_extension_operations, true)
  availability_set_resource_id                           = try(each.value.availability_set_resource_id, null)
  azure_backup_configurations                            = try(each.value.azure_backup_configurations, {})
  bypass_platform_safety_checks_on_user_schedule_enabled = true
  capacity_reservation_group_resource_id                 = try(each.value.capacity_reservation_group_resource_id, null)
  custom_data                                            = try(each.value.custom_data, null)
  data_disk_managed_disks                                = try(each.value.data_disk_managed_disks, {})
  dedicated_host_group_resource_id                       = try(each.value.dedicated_host_group_resource_id, null)
  dedicated_host_resource_id                             = try(each.value.dedicated_host_resource_id, null)
  disk_controller_type                                   = try(each.value.disk_controller_type, null)
  edge_zone                                              = try(each.value.edge_zone, null)
  encryption_at_host_enabled                             = try(each.value.encryption_at_host_enabled, true)
  eviction_policy                                        = try(each.value.eviction_policy, null)
  extensions                                             = try(each.value.extensions, {})
  gallery_applications                                   = try(each.value.gallery_applications, {})
  hotpatching_enabled                                    = try(each.value.hotpatching_enabled, false)
  license_type                                           = try(each.value.license_type, null)
  lock                                                   = try(each.value.lock, null)
  maintenance_configuration_resource_ids                 = try(each.value.maintenance_configuration_resource_ids, {})
  managed_identities = try(each.value.managed_identities, {
    system_assigned            = true
    user_assigned_resource_ids = []
  })
  max_bid_price                         = try(each.value.max_bid_price, -1)
  patch_assessment_mode                 = try(each.value.patch_assessment_mode, "AutomaticByPlatform")
  patch_mode                            = try(each.value.patch_mode, "AutomaticByPlatform")
  plan                                  = try(each.value.plan, null)
  platform_fault_domain                 = try(each.value.platform_fault_domain, null)
  priority                              = try(each.value.priority, "Regular")
  proximity_placement_group_resource_id = try(each.value.proximity_placement_group_resource_id, null)
  reboot_setting                        = try(each.value.reboot_setting, "IfRequired")
  secure_boot_enabled                   = try(each.value.secure_boot_enabled, true)
  secrets                               = try(each.value.secrets, [])
  source_image_reference = try(each.value.source_image_reference, {
    publisher = "canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  })
  source_image_resource_id              = try(each.value.source_image_resource_id, null)
  tags                                  = try(each.value.tags, local.default_tags)
  termination_notification              = try(each.value.termination_notification, null)
  user_data                             = try(each.value.user_data, null)
  virtual_machine_scale_set_resource_id = try(each.value.virtual_machine_scale_set_resource_id, null)
  vm_additional_capabilities            = try(each.value.vm_additional_capabilities, null)
  vtpm_enabled                          = try(each.value.vtpm_enabled, true)

}
