# =============================================
# Store Application
# =============================================

# Frontend

# NonProd
resource "azurerm_network_manager_network_group" "store_frontend_nonprod_auea" {
  name               = "NG-Store-Frontend-NonProd"
  network_manager_id = azurerm_network_manager.avnm.id
  description        = "Store frontend subnets - NonProd AUEA"
  member_type        = "VirtualNetwork"
}

# =============================================
# Add your actual Subnets / VNets here
# =============================================
resource "azurerm_network_manager_static_member" "store_frontend_nonprod_members" {
  for_each = toset([
    "/subscriptions/dca9be48-88b1-43e3-adfb-4a8d1ac1220e/resourceGroups/Testresourceforroma/providers/Microsoft.Network/virtualNetworks/testromanvnet",
    # Add more VNets or full Subnet IDs
  ])

  name                      = "member-${basename(each.value)}"
  network_group_id          = azurerm_network_manager_network_group.store_frontend_nonprod_auea.id
  target_virtual_network_id = each.value
}

// resource "azurerm_network_manager_static_member" "store_frontend_nonprod_members" {

//   for_each = {
//     subnet1 = data.azurerm_subnet.frontend_subnet1.id
//     subnet2 = data.azurerm_subnet.frontend_subnet2.id
//   }


//   name = "member-${basename(each.value)}"

//   network_group_id = azurerm_network_manager_network_group.store_frontend_nonprod_auea.id

//   target_virtual_network_id = each.value
// }

// resource "azurerm_network_manager_static_member" "store_frontend_nonprod_members" {

//   for_each = {
//     avnmsubnet = "/subscriptions/dca9be48-88b1-43e3-adfb-4a8d1ac1220e/resourceGroups/Testresourceforroma/providers/Microsoft.Network/virtualNetworks/testromanvnet/subnets/avnmsubnet"

//     subnet2 = "/subscriptions/dca9be48-88b1-43e3-adfb-4a8d1ac1220e/resourceGroups/Testresourceforroma/providers/Microsoft.Network/virtualNetworks/testromanvnet/subnets/subnet2"
//   }

//   name = "member-${each.key}"

//   network_group_id = azurerm_network_manager_network_group.store_frontend_nonprod_auea.id

//   target_virtual_network_id = each.value
// }

// resource "azurerm_network_manager_static_member" "store_backend_nonprod_members" {
//   for_each = toset([
//     "/subscriptions/dca9be48-88b1-43e3-adfb-4a8d1ac1220e/resourceGroups/Testresourceforroma/providers/Microsoft.Network/virtualNetworks/testromanvnet/subnets/subnet2",
//     # Add more...
//   ])

//   name                      = "member-${basename(each.value)}"
//   network_group_id          = azurerm_network_manager_network_group.store_backend_nonprod_auea.id
//   target_virtual_network_id = each.value
// }