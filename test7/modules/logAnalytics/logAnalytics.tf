#### The main Terraform module to create Management Policy            ####
#### Author:                                                          ####
#### Date:                                                            ####
#### Version: 0.1                                                     ####
#### File Name: logAnalytics.tf                                       ####
#### Description: This script to deploy Azure Landing Zone            ####
#### azurerm version = "~>3.0"                                        ####

terraform {
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = "~>3.0"
      configuration_aliases = [azurerm]
    }
  }
}

resource "random_id" "workspace" {
  byte_length = 8
}

resource "azurerm_log_analytics_workspace" "ad_workspace" {
  name                = "${var.log_analytics_name}-${random_id.workspace.hex}"
  location            = var.log_analytics_location
  resource_group_name = var.log_analytics_rg_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_log_analytics_solution" "ad_solution" {
  solution_name         = "AzureActivity"
  location              = azurerm_log_analytics_workspace.ad_workspace.location
  resource_group_name   = var.log_analytics_rg_name
  workspace_resource_id = azurerm_log_analytics_workspace.ad_workspace.id
  workspace_name        = azurerm_log_analytics_workspace.ad_workspace.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/AzureActivity"
  }
}