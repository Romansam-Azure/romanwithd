variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "key_vault_resource_group" {
  description = "The resource group for the Key Vault"
  type        = string
}

variable "location" {
  description = "The Azure region for resources"
  type        = string
}

variable "deployment_id" {
  description = "Deployment ID for naming resources"
  type        = string
}

variable "key_vault_name" {
  description = "The name of the Key Vault"
  type        = string
}

variable "sql_admin_username_secret" {
  description = "Key Vault secret name for SQL admin username"
  type        = string
}

variable "sql_admin_password_secret" {
  description = "Key Vault secret name for SQL admin password"
  type        = string
}

variable "sitecore_sku" {
  description = "Default SKU for Sitecore resources"
  type        = string
}

variable "sql_server_name" {
  description = "The name of the SQL Server"
  type        = string
}

variable "sql_server_version" {
  description = "The version of the SQL Server"
  type        = string
}

variable "sql_database_collation" {
  description = "The collation for SQL databases"
  type        = string
}

variable "core_sql_database_name" {
  description = "Name of the core SQL database"
  type        = string
}

variable "security_sql_database_name" {
  description = "Name of the security SQL database"
  type        = string
}

variable "master_sql_database_name" {
  description = "Name of the master SQL database"
  type        = string
}

variable "web_sql_database_name" {
  description = "Name of the web SQL database"
  type        = string
}

variable "reporting_sql_database_name" {
  description = "Name of the reporting SQL database"
  type        = string
}

variable "pools_sql_database_name" {
  description = "Name of the pools SQL database"
  type        = string
}

variable "tasks_sql_database_name" {
  description = "Name of the tasks SQL database"
  type        = string
}

variable "forms_sql_database_name" {
  description = "Name of the forms SQL database"
  type        = string
}

variable "exm_master_sql_database_name" {
  description = "Name of the EXM master SQL database"
  type        = string
}

variable "shard_map_manager_sql_database_name" {
  description = "Name of the shard map manager SQL database"
  type        = string
}

variable "shard0_sql_database_name" {
  description = "Name of the shard0 SQL database"
  type        = string
}

variable "shard1_sql_database_name" {
  description = "Name of the shard1 SQL database"
  type        = string
}

variable "ref_data_sql_database_name" {
  description = "Name of the reference data SQL database"
  type        = string
}

variable "ma_sql_database_name" {
  description = "Name of the marketing automation SQL database"
  type        = string
}

variable "processing_engine_tasks_sql_database_name" {
  description = "Name of the processing engine tasks SQL database"
  type        = string
}

variable "processing_engine_storage_sql_database_name" {
  description = "Name of the processing engine storage SQL database"
  type        = string
}

variable "redis_cache_name" {
  description = "Name of the Redis Cache"
  type        = string
}

variable "application_insights_name" {
  description = "Name of the Application Insights"
  type        = string
}

variable "application_insights_location" {
  description = "Location for Application Insights"
  type        = string
}

variable "si_hosting_plan_name" {
  description = "Name of the SI hosting plan"
  type        = string
}

variable "cm_hosting_plan_name" {
  description = "Name of the CM hosting plan"
  type        = string
}

variable "cd_hosting_plan_name" {
  description = "Name of the CD hosting plan"
  type        = string
}

variable "prc_hosting_plan_name" {
  description = "Name of the PRC hosting plan"
  type        = string
}

variable "xc_basic_hosting_plan_name" {
  description = "Name of the xConnect basic hosting plan"
  type        = string
}

variable "xc_resource_intensive_hosting_plan_name" {
  description = "Name of the xConnect resource-intensive hosting plan"
  type        = string
}

variable "exm_dds_hosting_plan_name" {
  description = "Name of the EXM DDS hosting plan"
  type        = string
}

variable "si_web_app_name" {
  description = "Name of the SI web app"
  type        = string
}

variable "cm_web_app_name" {
  description = "Name of the CM web app"
  type        = string
}

variable "cd_web_app_name" {
  description = "Name of the CD web app"
  type        = string
}

variable "prc_web_app_name" {
  description = "Name of the PRC web app"
  type        = string
}

variable "xc_ref_data_web_app_name" {
  description = "Name of the xConnect reference data web app"
  type        = string
}

variable "xc_collect_web_app_name" {
  description = "Name of the xConnect collect web app"
  type        = string
}

variable "xc_search_web_app_name" {
  description = "Name of the xConnect search web app"
  type        = string
}

variable "ma_ops_web_app_name" {
  description = "Name of the marketing automation operations web app"
  type        = string
}

variable "ma_rep_web_app_name" {
  description = "Name of the marketing automation reporting web app"
  type        = string
}

variable "cortex_processing_web_app_name" {
  description = "Name of the Cortex processing web app"
  type        = string
}

variable "cortex_reporting_web_app_name" {
  description = "Name of the Cortex reporting web app"
  type        = string
}

variable "exm_dds_web_app_name" {
  description = "Name of the EXM DDS web app"
  type        = string
}

variable "deploy_platform" {
  description = "Whether to deploy platform roles"
  type        = bool
}

variable "deploy_xconnect" {
  description = "Whether to deploy xConnect services"
  type        = bool
}

variable "deploy_exm_dds" {
  description = "Whether to deploy EXM DDS"
  type        = bool
}

variable "azure_service_bus_namespace_name" {
  description = "Name of the Azure Service Bus namespace"
  type        = string
}

variable "azure_service_bus_sku_name" {
  description = "SKU name for the Azure Service Bus"
  type        = string
}

variable "azure_service_bus_queues" {
  description = "List of Service Bus queue names"
  type        = list(string)
}

variable "min_tls_version" {
  description = "Minimum TLS version for App Services"
  type        = string
}

variable "oms_workspace_name" {
  description = "Name of the OMS workspace"
  type        = string
}

variable "app_service_plans" {
  description = "Map of App Service Plans"
  type        = map(object({
    name = string
    sku  = string
  }))
}

variable "sitecore_roles" {
  description = "Map of Sitecore roles"
  type        = map(object({
    name   = string
    plan   = string
    deploy = bool
  }))
}

variable "xconnect_services" {
  description = "Map of xConnect services"
  type        = map(object({
    name   = string
    plan   = string
    deploy = bool
  }))
}

variable "autoscale_settings" {
  description = "Map of autoscale settings"
  type        = map(object({
    enabled          = bool
    min_capacity     = number
    max_capacity     = number
    default_capacity = number
    cpu_threshold    = number
  }))
}

variable "storage_account_resource_group" {
  description = "The resource group of the existing storage account for WDP storage"
  type        = string
}

variable "storage_account_id" {
  description = "The resource ID of the existing storage account for WDP storage"
  type        = string
}