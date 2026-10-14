# Existing Resource Group
data "azurerm_resource_group" "existing_rg" {
  name = var.resource_group_name
}

# Data sources for Key Vault and secrets
data "azurerm_key_vault" "keyvault" {
  name                = var.key_vault_name
  resource_group_name = var.key_vault_resource_group
}

data "azurerm_key_vault_secret" "sql_username" {
  name         = var.sql_admin_username_secret
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

data "azurerm_key_vault_secret" "sql_password" {
  name         = var.sql_admin_password_secret
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

# Data source for existing storage account
data "azurerm_storage_account" "sitecore_packages" {
  name                = "terrafmstorage01"
  resource_group_name = var.storage_account_resource_group
}

# SQL module
module "sql" {
  source                     = "./modules/sql"
  resource_group_name        = data.azurerm_resource_group.existing_rg.name
  location                   = data.azurerm_resource_group.existing_rg.location
  deployment_id              = var.deployment_id
  sql_server_name            = var.sql_server_name
  sql_admin_username         = data.azurerm_key_vault_secret.sql_username.value
  sql_admin_password         = data.azurerm_key_vault_secret.sql_password.value
  sql_server_version         = var.sql_server_version
  sql_database_collation     = var.sql_database_collation
  databases = {
    core                     = { name = var.core_sql_database_name }
    security                 = { name = var.security_sql_database_name }
    master                   = { name = var.master_sql_database_name }
    web                      = { name = var.web_sql_database_name }
    reporting                = { name = var.reporting_sql_database_name }
    pools                    = { name = var.pools_sql_database_name }
    tasks                    = { name = var.tasks_sql_database_name }
    forms                    = { name = var.forms_sql_database_name }
    exm_master               = { name = var.exm_master_sql_database_name }
    shard_map_manager        = { name = var.shard_map_manager_sql_database_name }
    shard0                   = { name = var.shard0_sql_database_name }
    shard1                   = { name = var.shard1_sql_database_name }
    ref_data                 = { name = var.ref_data_sql_database_name }
    ma                       = { name = var.ma_sql_database_name }
    processing_engine_tasks  = { name = var.processing_engine_tasks_sql_database_name }
    processing_engine_storage = { name = var.processing_engine_storage_sql_database_name }
  }
}

# App Service module
module "app_service" {
  source                     = "./modules/app_service"
  resource_group_name        = data.azurerm_resource_group.existing_rg.name
  location                   = data.azurerm_resource_group.existing_rg.location
  deployment_id              = var.deployment_id
  sitecore_sku               = var.sitecore_sku
  deploy_platform            = var.deploy_platform
  deploy_xconnect            = var.deploy_xconnect
  deploy_exm_dds             = var.deploy_exm_dds
  app_service_plans          = var.app_service_plans
  sitecore_roles             = var.sitecore_roles
  xconnect_services          = var.xconnect_services
  sql_server_fqdn            = module.sql.sql_server_fqdn
  min_tls_version            = var.min_tls_version
  autoscale_settings         = var.autoscale_settings
  storage_account_id         = data.azurerm_storage_account.sitecore_packages.id
  depends_on                 = [module.sql]
}

# Service Bus module
module "service_bus" {
  source                     = "./modules/service_bus"
  resource_group_name        = data.azurerm_resource_group.existing_rg.name
  location                   = data.azurerm_resource_group.existing_rg.location
  namespace_name             = var.azure_service_bus_namespace_name
  sku_name                   = var.azure_service_bus_sku_name
  queues                     = var.azure_service_bus_queues
  min_tls_version            = var.min_tls_version
}

# Redis Cache module
module "redis" {
  source                     = "./modules/redis"
  resource_group_name        = data.azurerm_resource_group.existing_rg.name
  location                   = data.azurerm_resource_group.existing_rg.location
  redis_cache_name           = var.redis_cache_name
  sitecore_sku               = var.sitecore_sku
}

# OMS Workspace module
module "oms" {
  source                     = "./modules/oms"
  resource_group_name        = data.azurerm_resource_group.existing_rg.name
  location                   = data.azurerm_resource_group.existing_rg.location
  oms_workspace_name         = var.oms_workspace_name
}

# Application Insights module
module "app_insights" {
  source                     = "./modules/app_insights"
  resource_group_name        = data.azurerm_resource_group.existing_rg.name
  location                   = data.azurerm_resource_group.existing_rg.location
  app_insights_name          = var.application_insights_name
  workspace_id               = module.oms.workspace_id
}