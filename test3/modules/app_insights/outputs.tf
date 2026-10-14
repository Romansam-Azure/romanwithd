# sitecore-xp-deployment/modules/app_insights/outputs.tf

output "instrumentation_key" {
  value = azurerm_application_insights.sitecore_app_insights.instrumentation_key
  sensitive = true
}