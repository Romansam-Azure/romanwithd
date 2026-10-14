output "APPLICATIONINSIGHTS_CONNECTION_STRING" { value = module.monitoring.application_insights_connection_string }
output "AZURE_LOCATION"                       { value = local.location }
output "AZURE_TENANT_ID"                      { value = data.azurerm_client_config.current.tenant_id }
output "AZURE_FUNCTION_NAME"                  { value = module.api.name }
output "AZURE_FUNCTION_URI"                   { value = module.api.uri }
output "SERVICE_WEB_NAME"                     { value = module.web.name }
output "SERVICE_WEB_URI"                      { value = module.web.uri }
output "AZURE_RESOURCE_GROUP"                 { value = azurerm_resource_group.main.name }