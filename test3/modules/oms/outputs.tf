# sitecore-xp-deployment/modules/oms/outputs.tf

output "workspace_id" {
  value = azurerm_log_analytics_workspace.sitecore_oms.id
}