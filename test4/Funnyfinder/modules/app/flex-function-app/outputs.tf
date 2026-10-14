output "name"                 { value = azurerm_linux_function_app.this.name }
output "uri"                  { value = "https://${azurerm_linux_function_app.this.default_hostname}" }
output "identity_principal_id"{ value = azurerm_linux_function_app.this.identity[0].principal_id }