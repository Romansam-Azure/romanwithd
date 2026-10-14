resource "azurerm_linux_web_app" "appservice" {
  name                      = var.name
  resource_group_name       = var.resource_group_name
  location                  = var.location
  service_plan_id           = var.service_plan_id
  https_only                = true
  client_certificate_enabled = true
  client_certificate_mode   = "Required"
  virtual_network_subnet_id = var.subnet_id

  identity {
    type = "SystemAssigned"
  }

  site_config {
    always_on              = true
    vnet_route_all_enabled = true
    ftps_state             = "FtpsOnly"
    http2_enabled          = true
    minimum_tls_version    = "1.2"
    remote_debugging_enabled = false
    app_command_line       = var.app_command_line

    application_stack {
      node_version = "20-lts"
    }

    dynamic "ip_restriction" {
      for_each = var.ip_restrictions
      content {
        ip_address = ip_restriction.value
        action     = "Allow"
        priority   = 100 + index(var.ip_restrictions, ip_restriction.value)
        name       = "RedShield-${index(var.ip_restrictions, ip_restriction.value)}"
      }
    }

    ip_restriction_default_action = "Deny"
  }

  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY"        = var.app_insights_key
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = var.app_insights_connection_string
    "WEBSITE_RUN_FROM_PACKAGE"              = "1"
  }

  tags = var.tags
}