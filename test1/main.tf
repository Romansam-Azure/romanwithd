locals {
  common_tags = merge({
    Environment = var.environment
    Owner       = "NZBlood BAT"
    Application = "ODNZ Website"
  }, var.tags)
}

#--------------------------------------------------------------
# Resource Group
#--------------------------------------------------------------
module "rg" {
  source   = "./modules/resource_group"
  name     = var.resource_group_name
  location = var.location
  tags     = local.common_tags
}

#--------------------------------------------------------------
# Networking
#--------------------------------------------------------------
module "networking" {
  source                         = "./modules/networking"
  prefix                         = var.prefix
  location                       = var.location
  resource_group_name            = module.rg.name
  address_space                  = var.vnet_address_space
  private_endpoint_subnet_name   = "${var.prefix}-SNET"
  private_endpoint_subnet_prefix = var.private_endpoint_subnet_prefix
  app_service_subnet_name        = "${var.prefix}-APPSERVICE-SNET"
  app_service_subnet_prefix      = var.app_service_subnet_prefix
  private_dns_resource_group_name = var.private_dns_resource_group_name
  tags                           = local.common_tags
}

#--------------------------------------------------------------
# Log Analytics + Application Insights
#--------------------------------------------------------------
module "log_analytics" {
  source              = "./modules/log_analytics"
  name                = var.log_analytics_name
  location            = var.location
  resource_group_name = module.rg.name
  tags                = local.common_tags
}

module "app_insights" {
  source              = "./modules/application_insights"
  name                = var.app_insights_name
  location            = var.location
  resource_group_name = module.rg.name
  workspace_id        = module.log_analytics.id
  tags                = local.common_tags
}

#--------------------------------------------------------------
# Key Vault
#--------------------------------------------------------------
module "key_vault" {
  source              = "./modules/key_vault"
  name                = var.key_vault_name
  location            = var.location
  resource_group_name = module.rg.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  tags                = local.common_tags
}

#--------------------------------------------------------------
# App Service Plan
#--------------------------------------------------------------
module "app_service_plan" {
  source              = "./modules/app_service_plan"
  name                = "${var.prefix}-app"
  location            = var.location
  resource_group_name = module.rg.name
  sku_name            = var.app_service_plan_sku
  tags                = local.common_tags
}

#--------------------------------------------------------------
# App Services (Next.js + Strapi)
#--------------------------------------------------------------
module "app_nextjs" {
  source              = "./modules/app_service"
  name                = var.app_service_nextjs_name
  location            = var.location
  resource_group_name = module.rg.name
  service_plan_id     = module.app_service_plan.id
  subnet_id           = module.networking.app_service_subnet_id
  app_command_line    = "node node_modules/next/dist/bin/next start -p 8080"
  app_insights_key    = module.app_insights.instrumentation_key
  ip_restrictions     = var.redshield_ip_ranges
  tags                = local.common_tags
}

module "app_strapi" {
  source              = "./modules/app_service"
  name                = var.app_service_strapi_name
  location            = var.location
  resource_group_name = module.rg.name
  service_plan_id     = module.app_service_plan.id
  subnet_id           = module.networking.app_service_subnet_id
  app_command_line    = "node node_modules/@strapi/strapi/bin/strapi.js start"
  app_insights_key    = module.app_insights.instrumentation_key
  ip_restrictions     = var.redshield_ip_ranges
  tags                = local.common_tags
}

#--------------------------------------------------------------
# PostgreSQL Flexible Server
#--------------------------------------------------------------
module "postgresql" {
  source                 = "./modules/postgresql_flexible"
  name                   = var.postgresql_name
  location               = var.location
  resource_group_name    = module.rg.name
  administrator_login    = var.postgresql_admin_login
  administrator_password = var.postgresql_admin_password
  sku_name               = var.postgresql_sku
  storage_mb             = var.postgresql_storage_mb
  ha_mode                = var.postgresql_ha_mode
  tenant_id              = data.azurerm_client_config.current.tenant_id
  tags                   = local.common_tags
}

#--------------------------------------------------------------
# Storage Accounts
#--------------------------------------------------------------
module "storage_nextjs" {
  source              = "./modules/storage_account"
  name                = var.storage_account_nextjs_name
  location            = var.location
  resource_group_name = module.rg.name
  tags                = local.common_tags
}

module "storage_media" {
  source              = "./modules/storage_account"
  name                = var.storage_account_media_name
  location            = var.location
  resource_group_name = module.rg.name
  tags                = local.common_tags
}

#--------------------------------------------------------------
# Private Endpoints
#--------------------------------------------------------------
# Key Vault
module "pe_key_vault" {
  source              = "./modules/private_endpoint"
  name                = "${var.key_vault_name}-pe"
  location            = var.location
  resource_group_name = module.rg.name
  subnet_id           = module.networking.private_endpoint_subnet_id
  resource_id         = module.key_vault.id
  subresource_name    = "vault"
  private_dns_zone_id = module.networking.private_dns_zone_ids["vault"]
  tags                = local.common_tags
}

# Storage Next.js
module "pe_storage_nextjs" {
  source              = "./modules/private_endpoint"
  name                = "${var.storage_account_nextjs_name}-pe"
  location            = var.location
  resource_group_name = module.rg.name
  subnet_id           = module.networking.private_endpoint_subnet_id
  resource_id         = module.storage_nextjs.id
  subresource_name    = "blob"
  private_dns_zone_id = module.networking.private_dns_zone_ids["blob"]
  tags                = local.common_tags
}

# Storage Media
module "pe_storage_media" {
  source              = "./modules/private_endpoint"
  name                = "${var.storage_account_media_name}-pe"
  location            = var.location
  resource_group_name = module.rg.name
  subnet_id           = module.networking.private_endpoint_subnet_id
  resource_id         = module.storage_media.id
  subresource_name    = "blob"
  private_dns_zone_id = module.networking.private_dns_zone_ids["blob"]
  tags                = local.common_tags
}

# PostgreSQL
module "pe_postgresql" {
  source              = "./modules/private_endpoint"
  name                = "${var.postgresql_name}-pe"
  location            = var.location
  resource_group_name = module.rg.name
  subnet_id           = module.networking.private_endpoint_subnet_id
  resource_id         = module.postgresql.id
  subresource_name    = "postgresqlServer"
  private_dns_zone_id = module.networking.private_dns_zone_ids["postgres"]
  tags                = local.common_tags
}

# Application Insights (monitor)
module "pe_app_insights" {
  source              = "./modules/private_endpoint"
  name                = "${var.app_insights_name}-pe"
  location            = var.location
  resource_group_name = module.rg.name
  subnet_id           = module.networking.private_endpoint_subnet_id
  resource_id         = module.app_insights.id
  subresource_name    = "azuremonitor"
  private_dns_zone_id = module.networking.private_dns_zone_ids["monitor"]
  tags                = local.common_tags
}