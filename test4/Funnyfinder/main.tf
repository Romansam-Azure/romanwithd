locals {
  location        = var.location
  rg_name         = var.resource_group_name != "" ? var.resource_group_name : "${local.abbr.resourcesResourceGroups}${var.environment_name}tes"
  resource_token  = lower(random_id.token.hex)
  tags = {
    "azd-env-name"     = var.environment_name
    "CreatedBy"        = "Luke.Murray@datacom.com"
    "Department"       = "App Artificial Intelligence"
    "Financial Owner"  = "angela.millward@datacom.com"
    "Technical Owner"  = "chiwai.chan@datacom.com"
    "Support Owner"    = "chiwai.chan@datacom.com"
    "Criticality"      = "1"
    "Description"      = "AI-powered chatbot that helps Melbourne Comedy Festival attendees discover and find shows"
    "Cost Centre"      = "K54297"
    "Team"             = "micf-funnyfinder@datacom.com"
    "SLA"              = "99.99"
    "RTO"              = "5 Minutes"
    "RPO"              = "60 Minutes"
    "Backup Policy"    = "Bronze"
    "DeployedUsing"    = "Terraform (IaC)"
  }

  key_vault_name               = "${local.abbr.keyVaultVaults}${local.resource_token}tes"
  function_app_name            = var.api_service_name != "" ? var.api_service_name : "${local.abbr.webSitesFunctions}api-${local.resource_token}tes2"
  deployment_storage_container = "app-package-${substr(local.function_app_name, 0, 32)}-${substr(local.resource_token, 0, 7)}"
  admin_password               = var.administrator_login_password != null ? var.administrator_login_password : random_password.admin.result
}

resource "azurerm_resource_group" "main" {
  name     = local.rg_name
  location = local.location
  tags     = local.tags
}

# Core Modules
module "storage" {
  source = "./modules/core/storage"

  name                = "${local.abbr.storageStorageAccounts}${local.resource_token}tes"
  resource_group_name = azurerm_resource_group.main.name
  location            = local.location
  sku                 = { name = var.storage_sku_name }
  containers          = [{ name = local.deployment_storage_container }]
  public_network_access = var.skip_vnet ? "Enabled" : "Disabled"
  network_acls        = var.skip_vnet ? {} : { default_action = "Deny" }
  tags                = local.tags
}

module "identity" {
  source = "./modules/core/identity"

  name                = "${local.abbr.managedIdentityUserAssignedIdentities}api-${local.resource_token}tes"
  resource_group_name = azurerm_resource_group.main.name
  location            = local.location
  tags                = local.tags
}

module "monitoring" {
  source = "./modules/core/monitoring/combined"

  log_analytics_name      = "${local.abbr.operationalInsightsWorkspaces}${local.resource_token}"
  app_insights_name       = "${local.abbr.insightsComponents}${local.resource_token}tes"
  resource_group_name     = azurerm_resource_group.main.name
  location                = local.location
  tags                    = local.tags
  disable_local_auth      = var.disable_local_auth
}

module "app_service_plan" {
  source = "./modules/core/host/app-service-plan"

  name                = "${local.abbr.webServerFarms}${local.resource_token}tes"
  resource_group_name = azurerm_resource_group.main.name
  location            = local.location
  sku                 = { name = "FC1", tier = "FlexConsumption" }
  kind                = "functionapp"
  tags                = local.tags
}

# API - Python Flex Function App
module "api" {
  source = "./modules/app/flex-function-app"

  name                        = local.function_app_name
  resource_group_name         = azurerm_resource_group.main.name
  location                    = local.location
  app_service_plan_id         = module.app_service_plan.id
  storage_account_name        = module.storage.name
  deployment_storage_container_name = local.deployment_storage_container
  application_insights_name   = module.monitoring.app_insights_name
  identity_id                 = module.identity.identity_id
  identity_client_id          = module.identity.client_id
  runtime_name                = "python"
  runtime_version             = "3.11"
  virtual_network_subnet_id   = var.skip_vnet ? "" : module.vnet[0].app_subnet_id
  app_settings                = {
    DB_USER     = "@Microsoft.KeyVault(SecretUri=https://${local.key_vault_name}.vault.azure.net/secrets/postgresAdminUsername)"
    DB_PASSWORD = "@Microsoft.KeyVault(SecretUri=https://${local.key_vault_name}.vault.azure.net/secrets/postgresAdminPassword)"
    DB_HOST     = module.postgresql.fqdn
    DB_NAME     = "ffdb"
    DB_PORT     = "5432"
  }
  tags = local.tags
}

# VNet (only when not skipping)
module "vnet" {
  source   = "./modules/core/virtual-network"   # Note: you already had this from earlier core
  count    = var.skip_vnet ? 0 : 1

  environment_name    = var.environment_name
  vnet_name           = "${local.abbr.networkVirtualNetworks}${local.resource_token}tes"
  resource_group_name = azurerm_resource_group.main.name
  location            = local.location
  tags                = local.tags
}

# Storage Private Endpoint
module "storage_private_endpoint" {
  source = "./modules/app/storage-private-endpoint"
  count  = var.skip_vnet ? 0 : 1

  name                = "pe-storage-${local.resource_token}"
  resource_group_name = azurerm_resource_group.main.name
  location            = local.location
  storage_account_id  = module.storage.id
  subnet_id           = module.vnet[0].pe_subnet_id
  tags                = local.tags
}

# Role Assignments
module "storage_role_api" {
  source = "./modules/app/storage-role-assignment"

  storage_account_name = module.storage.name
  resource_group_name  = azurerm_resource_group.main.name
  principal_id         = module.identity.principal_id
  role_definition_id   = "b7e6dc6d-f1e8-4753-8033-0f276bb0955b"
}

module "appinsights_role_api" {
  source = "./modules/app/storage-role-assignment"

  storage_account_name = module.monitoring.app_insights_name
  resource_group_name  = azurerm_resource_group.main.name
  principal_id         = module.identity.principal_id
  role_definition_id   = "3913510d-42f4-4e42-8a64-420c390055eb"
}

# Static Web App
module "web" {
  source = "./modules/app/static-web-app"

  name                = var.web_service_name != "" ? var.web_service_name : "${local.abbr.webStaticSites}web-${local.resource_token}tes"
  resource_group_name = azurerm_resource_group.main.name
  location            = "westus2"
  tags                = local.tags
}

# PostgreSQL Flexible Server
module "postgresql" {
  source = "./modules/app/postgresql-flexible-server"

  name                     = "${local.abbr.dBforPostgreSQLServers}${local.resource_token}tes"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = local.location
  sku_name                 = "Standard_D2ds_v5"
  tier                     = "GeneralPurpose"
  version                  = "16"
  administrator_login      = var.administrator_login_name
  administrator_password   = local.admin_password
  geo_redundant_backup     = true
  high_availability        = "ZoneRedundant"
  databases                = ["ffdb"]
  user_assigned_identity_id = module.identity.identity_id
  subnet_id                = var.skip_vnet ? null : module.vnet[0].pe_subnet_id
  private_dns_zone_id      = module.private_dns_zone.id
  tags                     = local.tags
}

module "private_dns_zone" {
  source = "./modules/app/private-dns-zone"   # simple module – I included it below in app for completeness

  name                = "privatelink.postgres.database.azure.com"
  resource_group_name = azurerm_resource_group.main.name
  vnet_id             = var.skip_vnet ? null : module.vnet[0].vnet_id
  tags                = local.tags
}

# Key Vault
module "key_vault" {
  source = "./modules/app/key-vault"

  name                    = local.key_vault_name
  resource_group_name     = azurerm_resource_group.main.name
  location                = local.location
  identity_principal_id   = module.identity.principal_id
  function_principal_id   = module.api.identity_principal_id
  postgres_admin_username = var.administrator_login_name
  postgres_admin_password = local.admin_password
  tags                    = local.tags
}