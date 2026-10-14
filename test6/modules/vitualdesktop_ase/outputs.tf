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
