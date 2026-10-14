resource "azurerm_linux_function_app" "this" {
  name                        = var.name
  resource_group_name         = var.resource_group_name
  location                    = var.location
  service_plan_id             = var.app_service_plan_id
  storage_account_name        = var.storage_account_name
  storage_uses_managed_identity = true

  identity {
    type         = "UserAssigned"
    identity_ids = [var.identity_id]
  }

  site_config {
    ftps_state          = "Disabled"
    minimum_tls_version = "1.2"
    cors {
      allowed_origins     = ["*"]
      support_credentials = false
    }
  }

  app_settings = merge(var.app_settings, {
    AzureWebJobsStorage__accountName      = var.storage_account_name
    AzureWebJobsStorage__credential       = "managedidentity"
    APPLICATIONINSIGHTS_CONNECTION_STRING = data.azurerm_application_insights.this.connection_string
  })

  function_app_config {
    deployment {
      storage {
        type  = "blobContainer"
        value = "https://${var.storage_account_name}.blob.core.windows.net/${var.deployment_storage_container_name}"
        authentication {
          type                            = "UserAssignedIdentity"
          user_assigned_identity_resource_id = var.identity_id
        }
      }
    }
    runtime {
      name    = var.runtime_name
      version = var.runtime_version
    }
  }

  virtual_network_subnet_id = var.virtual_network_subnet_id != "" ? var.virtual_network_subnet_id : null
  tags = var.tags
}

data "azurerm_application_insights" "this" {
  name                = var.application_insights_name
  resource_group_name = var.resource_group_name
}