output "name" { value = azurerm_static_web_app.this.name }
output "uri"  { value = "https://${azurerm_static_web_app.this.default_host_name}" }