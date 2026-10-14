resource "azurerm_network_manager_admin_rule_collection" "store" {
  name                            = "store-security-rules"
  security_admin_configuration_id = azapi_resource.security_admin_config.id

  network_group_ids = [
    azurerm_network_manager_network_group.store_frontend_nonprod_auea.id,
  ]

  description = "Security rules for Store application"
}

// resource "azurerm_network_manager_admin_rule" "guardrails_egress_block_unapproved_dns" {
//   name                     = "guardrails-egress-block-unapproved-dns"
//   admin_rule_collection_id = azurerm_network_manager_admin_rule_collection.store.id

//   access    = "Deny"
//   direction = "Outbound"
//   priority  = 100
//   protocol  = "Any"

//   # Source = Store Frontend
//   dynamic "source" {
//     for_each = [
//       azurerm_network_manager_network_group.store_frontend_nonprod_auea.id
//     ]

//     content {
//       address_prefix_type = "NetworkGroup"
//       address_prefix      = source.value
//     }
//   }

//   # Destination = Any
//   dynamic "destination" {
//     for_each = [
//       "0.0.0.0/0"
//     ]

//     content {
//       address_prefix_type = "IPPrefix"
//       address_prefix      = destination.value
//     }
//   }

//   destination_port_ranges = ["53"]
// }


# Use azapi for the rule that needs NetworkGroup support
resource "azapi_resource" "guardrails_egress_block_unapproved_test" {
  type      = "Microsoft.Network/networkManagers/securityAdminConfigurations/ruleCollections/rules@2024-05-01"
  name      = "guardrails-egress-block-unapproved-dns-test"
  parent_id = azurerm_network_manager_admin_rule_collection.store.id

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

# main.tf (or rules.tf)

# ------------------------------------------------------------------
# 200 Platform - plat-egress-dns-to-resolvers-store-np
# ------------------------------------------------------------------
resource "azapi_resource" "plat_egress_dns_to_resolvers_store_np" {
  type      = "Microsoft.Network/networkManagers/securityAdminConfigurations/ruleCollections/rules@2024-05-01"
  name      = "plat-egress-dns-to-resolvers-store-np"
  parent_id = azurerm_network_manager_admin_rule_collection.store.id

  schema_validation_enabled = false

  body = {
    kind = "Custom"
    properties = {
      access      = "Allow"
      direction   = "Outbound"
      priority    = 200
      protocol    = "Udp" # or "Any" - DNS is primarily UDP, TCP fallback
      description = "Platform egress DNS to resolvers (store nonprod)"

      sources = [
        {
          addressPrefixType = "NetworkGroup"
          addressPrefix     = azurerm_network_manager_network_group.store_frontend_nonprod_auea.id
        }
      ]

      destinations = [
        {
          addressPrefixType = "IPPrefix"
          addressPrefix     = var.dns_resolvers[0]
        }
      ]

      destinationPortRanges = ["53"]
    }
  }
}

# ------------------------------------------------------------------
# 250 - svcapps-dc-to-resolvers-store-sa-np
# ------------------------------------------------------------------
resource "azapi_resource" "svcapps_dc_to_resolvers_store_sa_np" {
  type      = "Microsoft.Network/networkManagers/securityAdminConfigurations/ruleCollections/rules@2024-05-01"
  name      = "svcapps-dc-to-resolvers-store-sa-np"
  parent_id = azurerm_network_manager_admin_rule_collection.store.id

  schema_validation_enabled = false

  body = {
    kind = "Custom"
    properties = {
      access      = "Allow"
      direction   = "Outbound"
      priority    = 250
      protocol    = "Udp"
      description = "SVC Apps DC to DNS resolvers"

      sources = [
        for ip in var.sccm_domain_controllers : {
          addressPrefixType = "IPPrefix"
          addressPrefix     = ip
        }
      ]

      destinations = [
        for cidr in azurerm_ip_group.store_np_frontend.cidrs : {
          addressPrefixType = "IPPrefix"
          addressPrefix     = cidr
        }
      ]

      destinationPortRanges = ["53"]
    }
  }
}

# ------------------------------------------------------------------
# 300 Private ingress - vpn-to-app-frontend-backend-https-store-np
# ------------------------------------------------------------------
resource "azapi_resource" "vpn_to_app_frontend_backend_https_store_np" {
  type      = "Microsoft.Network/networkManagers/securityAdminConfigurations/ruleCollections/rules@2024-05-01"
  name      = "vpn-to-app-frontend-backend-https-store-np"
  parent_id = azurerm_network_manager_admin_rule_collection.store.id

  schema_validation_enabled = false

  body = {
    kind = "Custom"
    properties = {
      access      = "Allow"
      direction   = "Inbound"   # Private ingress
      priority    = 300
      protocol    = "Tcp"
      description = "VPN to App Frontend/Backend HTTPS"

      sources = [
        {
          addressPrefixType = "IPPrefix"
          addressPrefix     = var.ng_remote_vpn
        },
        {
          addressPrefixType = "IPPrefix"
          addressPrefix     = var.se_vpn
        }
      ]

      destinations = [
        {
          addressPrefixType = "NetworkGroup"
          addressPrefix     = azurerm_network_manager_network_group.store_frontend_nonprod_auea.id
        }
      ]

      destinationPortRanges = ["443"]
    }
  }
}

# ------------------------------------------------------------------
# 310 Private inter-spoke - svcapps-dc-to-apps
# ------------------------------------------------------------------
resource "azapi_resource" "svcapps_dc_to_apps" {
  type      = "Microsoft.Network/networkManagers/securityAdminConfigurations/ruleCollections/rules@2024-05-01"
  name      = "svcapps-dc-to-apps"
  parent_id = azurerm_network_manager_admin_rule_collection.store.id

  schema_validation_enabled = false

  body = {
    kind = "Custom"
    properties = {
      access      = "Allow"
      direction   = "Outbound"
      priority    = 310
      protocol    = "Any"
      description = "SVC Apps DC to Apps"

      sources = [
        for ip in var.sccm_domain_controllers : {
          addressPrefixType = "IPPrefix"
          addressPrefix     = ip
        }
      ]

      destinations = [
        {
          addressPrefixType = "NetworkGroup"
          addressPrefix     = azurerm_network_manager_network_group.store_frontend_nonprod_auea.id
        }
      ]

      destinationPortRanges = ["53", "88", "123", "389", "636", "3268", "3269"] # Common DC ports + DNS
    }
  }
}

// # ------------------------------------------------------------------
// # 330 Private inter-spoke - svcapps-sccm-to-apps
// # ------------------------------------------------------------------
// resource "azapi_resource" "svcapps_sccm_to_apps" {
//   type      = "Microsoft.Network/networkManagers/securityAdminConfigurations/ruleCollections/rules@2024-05-01"
//   name      = "svcapps-sccm-to-apps"
//   parent_id = azurerm_network_manager_admin_rule_collection.store.id

//   schema_validation_enabled = false

//   body = {
//     properties = {
//       access      = "Allow"
//       direction   = "Outbound"
//       priority    = 330
//       protocol    = "Tcp"
//       description = "SVC Apps SCCM to Apps"

//       sources = [
//         {
//           addressPrefixType = "IPPrefix"
//           addressPrefix     = var.sccm
//         }
//       ]

//       destinations = [
//         {
//           addressPrefixType = "NetworkGroup"
//           addressPrefix     = azurerm_network_manager_network_group.store_frontend_nonprod_auea.id
//         }
//       ]

//       destinationPortRanges = ["10123", "80"]
//     }
//   }
// }

// # ------------------------------------------------------------------
// # 340 Private inter-spoke - svcapps-sccm-to-apps-vpn
// # ------------------------------------------------------------------
// resource "azapi_resource" "svcapps_sccm_to_apps_vpn" {
//   type      = "Microsoft.Network/networkManagers/securityAdminConfigurations/ruleCollections/rules@2024-05-01"
//   name      = "svcapps-sccm-to-apps-vpn"
//   parent_id = azurerm_network_manager_admin_rule_collection.store.id

//   schema_validation_enabled = false

//   body = {
//     properties = {
//       access      = "Allow"
//       direction   = "Outbound"
//       priority    = 340
//       protocol    = "Tcp"
//       description = "SVC Apps SCCM to Apps VPN"

//       sources = [
//         {
//           addressPrefixType = "IPPrefix"
//           addressPrefix     = var.sccm
//         }
//       ]

//       destinations = [
//         {
//           addressPrefixType = "IPPrefix"
//           addressPrefix     = var.ng_remote_vpn
//         },
//         {
//           addressPrefixType = "IPPrefix"
//           addressPrefix     = var.se_vpn
//         }
//       ]

//       destinationPortRanges = ["10123", "80"]
//     }
//   }
// }

# ------------------------------------------------------------------
# 400 Private inter-spoke - mulesoft-to-frontend
# ------------------------------------------------------------------
resource "azapi_resource" "mulesoft_to_frontend" {
  type      = "Microsoft.Network/networkManagers/securityAdminConfigurations/ruleCollections/rules@2024-05-01"
  name      = "mulesoft-to-frontend"
  parent_id = azurerm_network_manager_admin_rule_collection.store.id

  schema_validation_enabled = false

  body = {
    kind = "Custom"
    properties = {
      access      = "Allow"
      direction   = "Outbound"
      priority    = 400
      protocol    = "Tcp"
      description = "Mulesoft to Frontend"

      sources = [
        {
          addressPrefixType = "IPPrefix"
          addressPrefix     = var.mulesoft_frontend
        }
      ]

      destinations = [
        for ip in var.store_np_frontend : {
          addressPrefixType = "IPPrefix"
          addressPrefix     = ip
        }
      ]

      destinationPortRanges = ["443", "80", "5432"] # HTTPS + Mulesoft port
    }
  }
}

# ------------------------------------------------------------------
# 800 Guardrails - guardrails-egress-block-unapproved-dns (example you gave)
# ------------------------------------------------------------------
resource "azapi_resource" "new_egress_block_unapproved_dns" {
  type      = "Microsoft.Network/networkManagers/securityAdminConfigurations/ruleCollections/rules@2024-05-01"
  name      = "new-egress-block-unapproved-dns"
  parent_id = azurerm_network_manager_admin_rule_collection.store.id

  schema_validation_enabled = false

  body = {
    kind = "Custom"
    properties = {
      access      = "Deny"
      direction   = "Outbound"
      priority    = 800
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

# ------------------------------------------------------------------
# 810 Guardrails - guardrails-egress-svcapps-block-unapproved-dns
# ------------------------------------------------------------------
resource "azapi_resource" "new_egress_svcapps_block_unapproved_dns" {
  type      = "Microsoft.Network/networkManagers/securityAdminConfigurations/ruleCollections/rules@2024-05-01"
  name      = "new-egress-svcapps-block-unapproved-dns"
  parent_id = azurerm_network_manager_admin_rule_collection.store.id

  schema_validation_enabled = false

  body = {
    kind = "Custom"
    properties = {
      access      = "Deny"
      direction   = "Outbound"
      priority    = 810
      protocol    = "Any"
      description = "Block unapproved DNS from SVC Apps"

      sources = [
        for ip in var.sccm_domain_controllers : {
          addressPrefixType = "IPPrefix"
          addressPrefix     = ip
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

# ------------------------------------------------------------------
# 900 Deny - deny-any-any-terminal (catch-all)
# ------------------------------------------------------------------
resource "azapi_resource" "deny_any_any_terminal" {
  type      = "Microsoft.Network/networkManagers/securityAdminConfigurations/ruleCollections/rules@2024-05-01"
  name      = "deny-any-any-terminal"
  parent_id = azurerm_network_manager_admin_rule_collection.store.id

  schema_validation_enabled = false

  body = {
    kind = "Custom"
    properties = {
      access      = "Deny"
      direction   = "Outbound"
      priority    = 900
      protocol    = "Any"
      description = "Default deny all"

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

      # ✅ This is the fix
      destinationPortRanges = ["0-65535"]
    }
  }
}