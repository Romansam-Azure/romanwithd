terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.24.0"
    }
  }
}

provider "random" {
  # Configuration options
}

provider "azuread" {
  # Configuration options
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

// provider "azurerm" {
//   alias           = "production"
//   subscription_id = var.subscriptionProd
//   features {}
// }

provider "azurerm" {
  alias           = "shared"
  subscription_id = var.subscriptionShared
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}

// provider "azurerm" {
//   alias           = "mgmt"
//   subscription_id = var.subscriptionMgmt
//   features {}
// }