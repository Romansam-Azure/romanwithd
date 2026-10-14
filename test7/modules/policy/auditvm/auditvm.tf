# Policy Allow Locations Start ------------------------------

data "azurerm_policy_definition" "vm_unmangeddisk" {
  display_name = "Audit VMs that do not use managed disks"
}

resource "azurerm_subscription_policy_assignment" "vms_disk" {
  name                 = "Diskunmannagedpolicyassignment"
  subscription_id      = var.policy_scope
  policy_definition_id = data.azurerm_policy_definition.vm_unmangeddisk.id
  description          = "EPS Audit VMs that do not use managed disks"
  display_name         = "EPS Audit Unmanaged Disk"
  location             = "Australia East"
}