# Reference resources
data "azurerm_resource_group" "avnmrg" {
  name = var.resource_group_name
}

data "azurerm_subscription" "current" {
}

# =============================================
# Virtual Network Manager
# =============================================
resource "azurerm_network_manager" "avnm" {
  name                = var.network_manager_name
  location            = data.azurerm_resource_group.avnmrg.location
  resource_group_name = data.azurerm_resource_group.avnmrg.name
  scope_accesses      = ["SecurityAdmin"]
  description         = "AVNM - Production"

  scope {
    subscription_ids = [data.azurerm_subscription.current.id]
  }
}

resource "azapi_resource" "security_admin_config" {
  type      = "Microsoft.Network/networkManagers/securityAdminConfigurations@2024-05-01"
  name      = "security-admin-config"
  parent_id = azurerm_network_manager.avnm.id

  body = {
    properties = {
      description = "Security Admin Configuration"

      # This is the critical setting for using Network Groups in rules
      networkGroupAddressSpaceAggregationOption = "Manual"   # Use "Manual" or "Automatic"
    }
  }
}

resource "azurerm_network_manager_deployment" "security_admin" {
  network_manager_id = azurerm_network_manager.avnm.id
  location           = data.azurerm_resource_group.avnmrg.location
  scope_access       = "SecurityAdmin"

  configuration_ids = [
    azapi_resource.security_admin_config.id
  ]

  depends_on = [
    azurerm_network_manager_admin_rule_collection.store,
  ]
}