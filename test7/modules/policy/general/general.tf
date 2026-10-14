terraform {
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = "~>3.0"
      configuration_aliases = [azurerm]
    }
  }
}

resource "azurerm_user_assigned_identity" "manide" {
  location            = var.location
  name                = var.midname
  resource_group_name = var.resource_group_name
}

resource "azurerm_management_group_policy_assignment" "builtinassignment" {
  name                 = var.policyname
  management_group_id  = var.policy_scope
  policy_definition_id = var.policy_definition_id
  description          = var.description
  display_name         = var.display_name
  location             = var.location

  identity {
    type = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.manide.id ]
  }
}
