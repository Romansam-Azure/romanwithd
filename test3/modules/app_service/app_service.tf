resource "azurerm_service_plan" "sitecore_asp" {
  for_each            = var.app_service_plans
  name                = each.value.name
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Windows"
  sku_name            = each.value.sku == "Extra Small" ? "S1" : each.value.sku == "Small" ? "S2" : each.value.sku == "Medium" ? "S3" : each.value.sku == "PremiumV3" ? "P2v3" : "P1v2"

    tags = {
    "_amba-CpuPercentage-threshold-Override_" = "90" # 👈 Required for AMBA policy to avoid 'null' error
  }
}

resource "azurerm_windows_web_app" "sitecore_roles" {
  for_each            = { for k, v in var.sitecore_roles : k => v if v.deploy }
  name                = each.value.name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.sitecore_asp[each.value.plan].id
  https_only          = true

  identity {
    type = "SystemAssigned"
  }

  site_config {
    always_on            = true
    minimum_tls_version  = var.min_tls_version
  }
}

resource "azurerm_windows_web_app_slot" "sitecore_cd_staging_slot" {
  for_each        = { for k, v in var.sitecore_roles : k => v if v.deploy && k == "cd" }
  name            = "sitecorexp104-uat-cd-staging"
  app_service_id  = azurerm_windows_web_app.sitecore_roles[each.key].id
  https_only      = true

  identity {
    type = "SystemAssigned"
  }

  site_config {
    always_on            = true
    minimum_tls_version  = var.min_tls_version
  }

  depends_on = [azurerm_windows_web_app.sitecore_roles]
}

# resource "azurerm_windows_web_app_slot" "sitecore_cd_production_slot" {
#   for_each        = { for k, v in var.sitecore_roles : k => v if v.deploy && k == "cd" }
#   name            = "sitecorexp104-uat-cd-prod"
#   app_service_id  = azurerm_windows_web_app.sitecore_roles[each.key].id
#   https_only      = true
#
#   identity {
#     type = "SystemAssigned"
#   }
#
#   site_config {
#     always_on            = true
#     minimum_tls_version  = var.min_tls_version
#   }
#
#   depends_on = [azurerm_windows_web_app.sitecore_roles]
# }

resource "azurerm_windows_web_app" "xconnect_services" {
  for_each            = { for k, v in var.xconnect_services : k => v if v.deploy }
  name                = each.value.name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.sitecore_asp[each.value.plan].id
  https_only          = true

  identity {
    type = "SystemAssigned"
  }

  site_config {
    always_on            = true
    minimum_tls_version  = var.min_tls_version
  }
}

# Azure Cognitive Search for xc-search
resource "azurerm_search_service" "sitecore_search" {
  name                = "${var.deployment_id}-search"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "standard"
}

# Role Assignment for Managed Identities to access Blob Storage
resource "azurerm_role_assignment" "sitecore_roles_blob_access" {
  for_each             = { for k, v in var.sitecore_roles : k => v if v.deploy }
  scope                = var.storage_account_id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_windows_web_app.sitecore_roles[each.key].identity[0].principal_id
}

resource "azurerm_role_assignment" "sitecore_cd_staging_blob_access" {
  for_each             = { for k, v in var.sitecore_roles : k => v if v.deploy && k == "cd" }
  scope                = var.storage_account_id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_windows_web_app_slot.sitecore_cd_staging_slot[each.key].identity[0].principal_id
}

resource "azurerm_role_assignment" "xconnect_services_blob_access" {
  for_each             = { for k, v in var.xconnect_services : k => v if v.deploy }
  scope                = var.storage_account_id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_windows_web_app.xconnect_services[each.key].identity[0].principal_id
}

resource "azurerm_monitor_autoscale_setting" "sitecore_asp_autoscale" {
  for_each            = { for k, v in var.autoscale_settings : k => v if v.enabled }
  name                = "${var.app_service_plans[each.key].name}-autoscale"
  resource_group_name = var.resource_group_name
  location            = var.location
  target_resource_id  = azurerm_service_plan.sitecore_asp[each.key].id

  profile {
    name = "default"
    capacity {
      default = each.value.default_capacity
      minimum = each.value.min_capacity
      maximum = each.value.max_capacity
    }
    rule {
      metric_trigger {
        metric_name        = "CpuPercentage"
        metric_resource_id = azurerm_service_plan.sitecore_asp[each.key].id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = each.value.cpu_threshold
      }
      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT5M"
      }
    }
    rule {
      metric_trigger {
        metric_name        = "CpuPercentage"
        metric_resource_id = azurerm_service_plan.sitecore_asp[each.key].id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = 30
      }
      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT5M"
      }
    }
  }

  depends_on = [azurerm_service_plan.sitecore_asp]
}