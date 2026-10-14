terraform {
  required_version = ">= 1.10.0"

  required_providers {
    # The root of the configuration where Terraform Apply runs should specify the maximum allowed provider version.
    # https://developer.hashicorp.com/terraform/language/providers/requirements#best-practices-for-provider-versions
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.20.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.0"
    }
    azapi = {
      source  = "Azure/azapi"
      version = "~> 2.0"
    }
  }
}

provider "azurerm" {
  # withut this set, all resource providers will be enabled in the subscription when Terraform first runs
  # security recommendations are to only enable the providers that are required.
  resource_provider_registrations = "none"
  storage_use_azuread             = true

  features {
    resource_group {
      prevent_deletion_if_contains_resources = false # This is to handle MCAPS or other policy driven resource creation.
    }

    # some default safety features for Key Vault
    key_vault {
      purge_soft_delete_on_destroy    = false
      recover_soft_deleted_key_vaults = true
    }
  }
}

provider "azuread" {}
