output "vm_outputs" {
  description = "Map of VM names and resource IDs."
  value       = local.vm_outputs
}

// output "vm_windows_ids" {
//   description = "Map of Windows VM IDs from the vm_windows module."
//   value = {
//     for k, m in module.vm_windows :
//     k => m.id
//   }
// }


output "vm_windows_names" {
  description = "Map of Windows VM names from the vm_windows module."
  value = {
    for k, m in module.vm_windows :
    k => try(m.name, null)
  }
}

output "vm_windows_os_disk_ids" {
  description = "Map of Windows VM OS disk managed disk IDs."
  value = {
    for k, m in module.vm_windows :
    k => try(m.os_disk_id, null)
  }
}

output "vm_windows_private_ips" {
  description = "Map of Windows VM primary private IP addresses."
  value = {
    for k, m in module.vm_windows :
    k => try(m.private_ip, null)
  }
}




# debugging

# output "vm_key_vault_reference_map" {
#   value = local.vm_key_vault_reference_map
# }

# output "account_credentials_map" {
#   value = local.account_credentials_map
# }
