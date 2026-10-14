#Policy Allow Locations Start ------------------------------

data "azurerm_policy_definition" "storage_https" {
  display_name = "Secure transfer to storage accounts should be enabled"
}

resource "azurerm_subscription_policy_assignment" "storage_secure" {
  name                 = "securestorageassignment"
  subscription_id  = var.policy_scope
  policy_definition_id = data.azurerm_policy_definition.storage_https.id
  description          = "EPS Secure transfer to storage accounts should be enabled"
  display_name         = "EPS Secure Storage"

}

#Policy Allow Locations Ends ------------------------------