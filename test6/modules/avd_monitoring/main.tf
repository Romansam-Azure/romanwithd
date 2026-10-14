# Terraform module for AVD Monitoring

data "azurerm_virtual_machine" "session_host" {
  for_each = { for idx, id in var.session_host_ids : idx => id }

  name                = split("/", each.value)[8]   # VM name
  resource_group_name = split("/", each.value)[4]   # Resource-group name
}

# ROLE ASSIGNMENT
resource "azurerm_role_assignment" "ama_monitoring" {
  for_each = { for idx, id in var.session_host_ids : idx => id }

  scope                = azurerm_log_analytics_workspace.avd.id
  role_definition_name = "Monitoring Metrics Publisher"
  principal_id         = data.azurerm_virtual_machine.session_host[each.key].identity[0].principal_id
  lifecycle {
    
    ignore_changes = all
  }
}

# Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "avd" {
  name                = var.log_analytics_workspace_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.log_analytics_sku
  retention_in_days   = var.retention_in_days
  tags                = var.tags
}

# Diagnostic Settings for Host Pool
resource "azurerm_monitor_diagnostic_setting" "host_pool" {
  for_each = toset(var.host_pool_ids)
  name                       = "${var.diagnostic_setting_prefix}-hostpool"
  target_resource_id         = each.value
  log_analytics_workspace_id = azurerm_log_analytics_workspace.avd.id

  enabled_log {
    category = "Checkpoint"
  }
  enabled_log {
    category = "Error"
  }
  enabled_log {
    category = "Management"
  }
  enabled_log {
    category = "Connection"
  }
  enabled_log {
    category = "HostRegistration"
  }
  enabled_log {
    category = "AgentHealthStatus"
  }
  enabled_log {
    category = "NetworkData"
  }
  enabled_log {
    category = "ConnectionGraphicsData"
  }
  enabled_log {
    category = "SessionHostManagement"
  }
  enabled_log {
    category = "AutoscaleEvaluationPooled"
  }
}

# Diagnostic Settings for Application Group
resource "azurerm_monitor_diagnostic_setting" "app_group" {
  for_each = toset(var.application_group_ids)
  name                       = "${var.diagnostic_setting_prefix}-appgroup"
  target_resource_id         = each.value
  log_analytics_workspace_id = azurerm_log_analytics_workspace.avd.id

  enabled_log {
    category = "Checkpoint"
  }
  enabled_log {
    category = "Error"
  }
  enabled_log {
    category = "Management"
  }
}

# Diagnostic Settings for Workspace
resource "azurerm_monitor_diagnostic_setting" "workspace" {
  for_each = toset(var.workspace_ids)
  name                       = "${var.diagnostic_setting_prefix}-workspace"
  target_resource_id         = each.value
  log_analytics_workspace_id = azurerm_log_analytics_workspace.avd.id

  enabled_log {
    category = "Checkpoint"
  }
  enabled_log {
    category = "Error"
  }
  enabled_log {
    category = "Management"
  }
  enabled_log {
    category = "Feed"
  }
}

# Diagnostic Settings for Scaling Plan
resource "azurerm_monitor_diagnostic_setting" "scaling_plan" {
  for_each = var.scaling_plan_ids
  name                       = "${var.diagnostic_setting_prefix}-scalingplan"
  target_resource_id         = each.value
  log_analytics_workspace_id = azurerm_log_analytics_workspace.avd.id

  enabled_log {
    category = "Autoscale"
  }
}

# New: Data Collection Rule (DCR) for Session Host Monitoring
resource "azurerm_monitor_data_collection_rule" "avd_session_host" {
  name                = var.data_collection_rule_name
  resource_group_name = var.dcr_resource_group_name != null ? var.dcr_resource_group_name : var.resource_group_name
  location            = var.location
  kind                = "Windows"

  destinations {
    log_analytics {
      workspace_resource_id = var.session_host_workspace_id != null ? var.session_host_workspace_id : azurerm_log_analytics_workspace.avd.id
      name                 = "avdla"
    }
  }

  data_flow {
    streams      = ["Microsoft-Perf", "Microsoft-Event"]
    destinations = ["avdla"]
  }

  # Performance Counters (AVD-recommended for session hosts)
  data_sources {
    performance_counter {
      name                          = "AVDPerfCounters"
      streams                       = ["Microsoft-Perf"]
      sampling_frequency_in_seconds = 15
      counter_specifiers = [
        "\\\\LogicalDisk(_Total)\\\\Free Megabytes",
        "\\\\Memory\\\\% Committed Bytes In Use",
        "\\\\Memory\\\\Available MBytes",
        "\\\\Processor(_Total)\\\\% Processor Time"
      ]
    }
  # Windows Event Logs (AVD-recommended: Security, System, Application, TerminalServices)
    windows_event_log {
      name    = "AVDWELogs"
      streams = ["Microsoft-Event"]
      x_path_queries = [
        "Security!*[System[(Level=1 or Level=2 or Level=3 or Level=4 or Level=5)]]",
        "System!*[System[(Level=1 or Level=2 or Level=3 or Level=4 or Level=5)]]",
        "Application!*[System[(Level=1 or Level=2 or Level=3 or Level=4 or Level=5)]]",
        "Microsoft-Windows-TerminalServices-LocalSessionManager/Operational!*[System[(Level=1 or Level=2 or Level=3 or Level=4 or Level=5)]]",
        "Microsoft-Windows-TerminalServices-RemoteConnectionManager/Operational!*[System[(Level=1 or Level=2 or Level=3 or Level=4 or Level=5)]]",
        "Microsoft-Windows-GroupPolicy/Operational!*[System[(Level=1 or Level=2 or Level=3 or Level=4 or Level=5)]]"
      ]
    }
  }
  tags = var.tags
  lifecycle {
    
    ignore_changes = all
  } 
}

# ------------------------------------------------------------------
# DCR Association – Session Host (use count, stable names)
# ------------------------------------------------------------------
// resource "azurerm_monitor_data_collection_rule_association" "avd_session_host" {
//   count = length(var.session_host_ids)

//   name = "${var.diagnostic_setting_prefix}-sessionhost-assoc-${substr(sha1(var.session_host_ids[count.index]), 0, 8)}"

//   target_resource_id      = var.session_host_ids[count.index]
//   data_collection_rule_id = azurerm_monitor_data_collection_rule.avd_session_host.id

//   depends_on = [azurerm_monitor_data_collection_rule.avd_session_host]
// }

// resource "azurerm_monitor_data_collection_rule_association" "avd_session_host" {
//   for_each = toset(var.session_host_ids)

//   name                    = "${var.diagnostic_setting_prefix}-sessionhost-assoc-${substr(sha1(each.value), 0, 8)}"
//   target_resource_id      = each.value
//   data_collection_rule_id = azurerm_monitor_data_collection_rule.avd_session_host.id

//   depends_on = [azurerm_monitor_data_collection_rule.avd_session_host]
// }

resource "azurerm_monitor_data_collection_rule_association" "avd_session_host" {
  for_each = { for idx, id in var.session_host_ids : idx => id }

  name                    = "${var.diagnostic_setting_prefix}-assoc-${substr(sha1(each.value), 0, 8)}"
  target_resource_id      = each.value
  data_collection_rule_id = azurerm_monitor_data_collection_rule.avd_session_host.id
  lifecycle {
    ignore_changes = all
  }
}

# ------------------------------------------------------------------
# Azure Monitor Agent (AMA) Extension – Session Host (also use count)
# ------------------------------------------------------------------
// resource "azurerm_virtual_machine_extension" "ama_session_host" {
//   count = var.deploy_ama_extension ? length(var.session_host_ids) : 0

//   name                 = "AzureMonitorWindowsAgent"
//   virtual_machine_id   = var.session_host_ids[count.index]
//   publisher            = "Microsoft.Azure.Monitor"
//   type                 = "AzureMonitorWindowsAgent"
//   type_handler_version = "1.13"

//   settings = jsonencode({
//     Authentication = {
//       ManagedIdentity = {
//         identifier = { systemAssignedIdentity = true }
//       }
//     }
//   })

//   tags = var.tags

//   depends_on = [
//     azurerm_monitor_data_collection_rule.avd_session_host,
//     azurerm_monitor_data_collection_rule_association.avd_session_host
//   ]
// }

// resource "azurerm_virtual_machine_extension" "ama_session_host" {
//   for_each = var.deploy_ama_extension ? toset(var.session_host_ids) : []

//   name                 = "AzureMonitorWindowsAgent"
//   virtual_machine_id   = each.value
//   publisher            = "Microsoft.Azure.Monitor"
//   type                 = "AzureMonitorWindowsAgent"
//   type_handler_version = "1.13"

//   settings = jsonencode({
//     Authentication = {
//       ManagedIdentity = {
//         identifier = { systemAssignedIdentity = true }
//       }
//     }
//   })

//   tags = var.tags

//   depends_on = [
//     azurerm_monitor_data_collection_rule.avd_session_host,
//     azurerm_monitor_data_collection_rule_association.avd_session_host
//   ]
// }

resource "azurerm_virtual_machine_extension" "ama_session_host" {
  for_each = var.deploy_ama_extension ? { for idx, id in var.session_host_ids : idx => id } : {}

  name               = "AzureMonitorWindowsAgent"
  virtual_machine_id = each.value
  publisher          = "Microsoft.Azure.Monitor"
  type               = "AzureMonitorWindowsAgent"
  type_handler_version = "1.13"

  settings = jsonencode({
    Authentication = {
      ManagedIdentity = {
        identifier = { systemAssignedIdentity = true }
      }
    }
  })

  tags = var.tags

  depends_on = [
    azurerm_monitor_data_collection_rule.avd_session_host,
    azurerm_monitor_data_collection_rule_association.avd_session_host
  ]
  lifecycle {
    
    ignore_changes = all
  }
}