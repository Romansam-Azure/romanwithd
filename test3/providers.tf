terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.89.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.47.0"
    }
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = ">=1.0"
    }
  }

  required_version = ">= 1.4.0"
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy    = false
      recover_soft_deleted_key_vaults = true
    }
  }

  use_oidc                   = true
  tenant_id                  = "9b137b97-8345-4a72-a060-5e083e8364c6"
  subscription_id            = "dca9be48-88b1-43e3-adfb-4a8d1ac1220e"
  client_id                  = "30dc4469-2fc8-4d5c-b240-3a3b0e225927"
  skip_provider_registration = true
}

provider "azuredevops" {
  use_oidc = true
}
