# sitecore-xp-deployment/modules/service_bus/outputs.tf

output "namespace_name" {
  value = azurerm_servicebus_namespace.sitecore_asb.name
}