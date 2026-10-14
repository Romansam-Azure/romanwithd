# sitecore-xp-deployment/modules/app_insights/main.tf

resource "azurerm_application_insights" "sitecore_app_insights" {
  name                = var.app_insights_name
  resource_group_name = var.resource_group_name
  location            = var.location
  application_type    = "web"
  workspace_id        = var.workspace_id  # ✅ link to Log Analytics
}