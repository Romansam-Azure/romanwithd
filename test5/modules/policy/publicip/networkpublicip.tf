# Policy Allow Locations Start ------------------------------

data "azurerm_policy_definition" "publicip_network" {
  display_name = "Network interfaces should not have public IPs"
}

resource "azurerm_subscription_policy_assignment" "publicip_neti" {
  name                 = "tagspolicyassignment"
  subscription_id      = var.policy_scope
  policy_definition_id = data.azurerm_policy_definition.publicip_network.id
  description          = "EPS Network interfaces should not have public IPs"
  display_name         = "EPS Deny publicip on Network Interface"
  location             = "Australia East"
}
