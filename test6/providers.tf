# providers.tf
terraform {
  required_version = ">= 1.5"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
    azapi = {
      source  = "azure/azapi"
      version = "~>2.6.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.53.1"  # CRITICAL: Upgrade from 2.24.0
    }
    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
  }
}

# === AZUREAD (uses same OIDC) ===
provider "azuread" {
  // use_oidc                   = true
  // tenant_id                  = "e60ce638-7fe6-4656-80a3-2fd85e9c2525"
  // client_id                  = "6864b145-bc2a-4625-8f67-36bb75ccffa2"
}

# === AZAPI (must be explicitly configured) ===
provider "azapi" {}

# === AZURE RM (default) ===
provider "azurerm" {
  features {}
  // use_oidc                   = true
  // tenant_id                  = "e60ce638-7fe6-4656-80a3-2fd85e9c2525"
  // subscription_id            = "ee3f4544-7b5f-44f7-af75-2a4ca66cfeec"
  // client_id                  = "6864b145-bc2a-4625-8f67-36bb75ccffa2"
  // skip_provider_registration = true
}

# === PRODUCTION ALIAS ===
provider "azurerm" {
  alias           = "production"
  subscription_id = var.subscriptionProd
  features {}

  // use_oidc                   = true
  // tenant_id                  = "e60ce638-7fe6-4656-80a3-2fd85e9c2525"
  // subscription_id            = "ee3f4544-7b5f-44f7-af75-2a4ca66cfeec"
  // client_id                  = "6864b145-bc2a-4625-8f67-36bb75ccffa2"
  // skip_provider_registration = true
}