output "id"                   { value = azurerm_linux_web_app.appservice.id }
output "default_hostname"     { value = azurerm_linux_web_app.appservice.default_hostname }
output "identity_principal_id"{ value = azurerm_linux_web_app.appservice.identity[0].principal_id }