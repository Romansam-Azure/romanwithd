resource "azapi_resource" "security_admin_config_np" {
  type      = "Microsoft.Network/networkManagers/securityAdminConfigurations@2024-05-01"
  name      = "security-admin-config-np"
  parent_id = azurerm_network_manager.avnm.id

  body = {
    properties = {
      description = "Security Admin Configuration"

      # This is the critical setting for using Network Groups in rules
      networkGroupAddressSpaceAggregationOption = "Manual"   # Use "Manual" or "Automatic"
    }
  }
}

resource "azurerm_network_manager_deployment" "security_admin_np" {
  network_manager_id = azurerm_network_manager.avnm.id
  location           = data.azurerm_resource_group.avnmrg.location
  scope_access       = "SecurityAdmin"

  configuration_ids = [
    azapi_resource.security_admin_config_np.id
  ]

  depends_on = [
    azurerm_network_manager_admin_rule_collection.store_np,
  ]
}


resource "azurerm_network_manager_admin_rule_collection" "store_np" {
  name                            = "store-security-rules-np"
  security_admin_configuration_id = azapi_resource.security_admin_config_np.id

  network_group_ids = [
    azurerm_network_manager_network_group.store_frontend_nonprod_auea.id,
  ]

  description = "Security rules for Store application"
}



# Use azapi for the rule that needs NetworkGroup support
resource "azapi_resource" "guardrails_egress_block_unapproved_npp" {
  type      = "Microsoft.Network/networkManagers/securityAdminConfigurations/ruleCollections/rules@2024-05-01"
  name      = "guardrails-egress-block-unapproved-dns-npp"
  parent_id = azurerm_network_manager_admin_rule_collection.store_np.id

  schema_validation_enabled = false     # Disable strict validation for this preview resource

  body = {
    kind = "Custom"
    properties = {
      access      = "Deny"
      direction   = "Outbound"
      priority    = 100
      protocol    = "Any"
      description = "Block unapproved DNS egress"

      sources = [
        {
          addressPrefixType = "NetworkGroup"
          addressPrefix     = azurerm_network_manager_network_group.store_frontend_nonprod_auea.id
        }
      ]

      destinations = [
        {
          addressPrefixType = "IPPrefix"
          addressPrefix     = "0.0.0.0/0"
        }
      ]

      destinationPortRanges = ["53"]
    }
  }
}