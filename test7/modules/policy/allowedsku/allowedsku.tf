#Policy Allow Locations Start ------------------------------

data "azurerm_policy_definition" "allow_sku" {
  display_name = "Allowed virtual machine size SKUs"
}

resource "azurerm_subscription_policy_assignment" "allowed_sku" {
  name                 = "Allowedskuassignment"
  subscription_id  = var.policy_scope
  policy_definition_id = data.azurerm_policy_definition.allow_sku.id
  description          = "EPS Allowed virtual machine size SKUs"
  display_name         = "EPS Allowed SKUs"

  metadata = <<METADATA
    {
    "category": "General"
    }
METADATA

  parameters = <<PARAMETERS
{
  "listOfAllowedSKUs": {
    "value": [ 
      "Standard_B2s",
      "Standard_D2s_v3",
      "Standard_F2s",
      "Standard_E2s_v3",
      "Standard_A2_v2"
     ]
  }
}
PARAMETERS

}

#Policy Allow Locations Ends ------------------------------