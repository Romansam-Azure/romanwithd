# sitecore-xp-deployment/modules/app_service/outputs.tf

output "app_service_urls" {
  value = {
    sitecore_roles       = { for k, app in azurerm_windows_web_app.sitecore_roles : k => app.default_hostname }
    xconnect_services    = { for k, app in azurerm_windows_web_app.xconnect_services : k => app.default_hostname }
  }
}
