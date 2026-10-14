output "host_pool_id" {
  value = azurerm_virtual_desktop_host_pool.personal_pool.id
}

output "registration_token" {
  value = azurerm_virtual_desktop_host_pool_registration_info.avdtoken.token
  sensitive = true
}

output "workspace_id" {
  value = local.workspace_id
}

output "session_host_ids" {
  description = "List of resource IDs for the session host VMs"
  value       = [for vm in azurerm_windows_virtual_machine.session_host : vm.id]
}
