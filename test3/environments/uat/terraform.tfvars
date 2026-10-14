resource_group_name = "sitecore-xp-prod-rg"
key_vault_resource_group = "resourceforroma"
location = "Australia East"
deployment_id = "sitecorexp102-uat"
key_vault_name = "hubkvame"
sql_admin_username_secret = "sql-admin-username-uat"
sql_admin_password_secret = "sql-admin-password-uat"
sitecore_sku = "Extra Small" # Default SKU, overridden by app_service_plans
sql_server_name = "sitecorexp102-uat-sql"
sql_server_version = "12.0"
sql_database_collation = "SQL_Latin1_General_CP1_CI_AS"
core_sql_database_name = "sitecorexp102-uat-core-db"
security_sql_database_name = "sitecorexp102-uat-security-db"
master_sql_database_name = "sitecorexp102-uat-master-db"
web_sql_database_name = "sitecorexp102-uat-web-db"
reporting_sql_database_name = "sitecorexp102-uat-reporting-db"
pools_sql_database_name = "sitecorexp102-uat-pools-db"
tasks_sql_database_name = "sitecorexp102-uat-tasks-db"
forms_sql_database_name = "sitecorexp102-uat-forms-db"
exm_master_sql_database_name = "sitecorexp102-uat-exmmaster-db"
shard_map_manager_sql_database_name = "sitecorexp102-uat-smm-db"
shard0_sql_database_name = "sitecorexp102-uat-shard0-db"
shard1_sql_database_name = "sitecorexp102-uat-shard1-db"
ref_data_sql_database_name = "sitecorexp102-uat-refdata-db"
ma_sql_database_name = "sitecorexp102-uat-ma-db"
processing_engine_tasks_sql_database_name = "sitecorexp102-uat-processingenginetasks-db"
processing_engine_storage_sql_database_name = "sitecorexp102-uat-processingenginestorage-db"
redis_cache_name = "sitecorexp102-uat-redis"
application_insights_name = "sitecorexp102-uat-ai"
application_insights_location = "Australia East"
si_hosting_plan_name = "sitecorexp102-uat-si-hp"
cm_hosting_plan_name = "sitecorexp102-uat-cm-hp"
cd_hosting_plan_name = "sitecorexp102-uat-cd-hp"
prc_hosting_plan_name = "sitecorexp102-uat-prc-hp"
xc_basic_hosting_plan_name = "sitecorexp102-uat-xc-basic-hp"
xc_resource_intensive_hosting_plan_name = "sitecorexp102-uat-xc-resourceintensive-hp"
exm_dds_hosting_plan_name = "sitecorexp102-uat-exm-dds-hp"
si_web_app_name = "sitecorexp102-uat-si"
cm_web_app_name = "sitecorexp102-uat-cm"
cd_web_app_name = "sitecorexp102-uat-cd"
prc_web_app_name = "sitecorexp102-uat-prc"
xc_ref_data_web_app_name = "sitecorexp102-uat-xc-refdata"
xc_collect_web_app_name = "sitecorexp102-uat-xc-collect"
xc_search_web_app_name = "sitecorexp102-uat-xc-search"
ma_ops_web_app_name = "sitecorexp102-uat-ma-ops"
ma_rep_web_app_name = "sitecorexp102-uat-ma-rep"
cortex_processing_web_app_name = "sitecorexp102-uat-cortex-processing"
cortex_reporting_web_app_name = "sitecorexp102-uat-cortex-reporting"
exm_dds_web_app_name = "sitecorexp102-uat-exm-dds"
deploy_platform = true
deploy_xconnect = true
deploy_exm_dds = false
azure_service_bus_namespace_name = "sitecorexp102-uat-asb"
azure_service_bus_sku_name = "Standard"
min_tls_version = "1.2"
oms_workspace_name = "sitecorexp102-uat-oms"
storage_account_resource_group = "resourceforroma" # Adjust if storage account is in a different RG
storage_account_id = "/subscriptions/dca9be48-88b1-43e3-adfb-4a8d1ac1220e/resourceGroups/resourceforroma/providers/Microsoft.Storage/storageAccounts/terrafmstorage01//packages"

# App Service Plans with specific SKUs
app_service_plans = {
  "si" = {
    name = "sitecorexp102-uat-si-hp"
    sku  = "Extra Small"
  }
  "cm" = {
    name = "sitecorexp102-uat-cm-hp"
    sku  = "PremiumV3"
  }
  "cd" = {
    name = "sitecorexp102-uat-cd-hp"
    sku  = "PremiumV3"
  }
  "prc" = {
    name = "sitecorexp102-uat-prc-hp"
    sku  = "Extra Small"
  }
  "xc_basic" = {
    name = "sitecorexp102-uat-xc-basic-hp"
    sku  = "Extra Small"
  }
  "xc_resource_intensive" = {
    name = "sitecorexp102-uat-xc-resourceintensive-hp"
    sku  = "Extra Small"
  }
  "exm_dds" = {
    name = "sitecorexp102-uat-exm-dds-hp"
    sku  = "Extra Small"
  }
}

# Sitecore Roles
sitecore_roles = {
  "si" = {
    name   = "sitecorexp102-uat-si"
    plan   = "si"
    deploy = true
  }
  "cm" = {
    name   = "sitecorexp102-uat-cm"
    plan   = "cm"
    deploy = true
  }
  "cd" = {
    name   = "sitecorexp102-uat-cd"
    plan   = "cd"
    deploy = true
  }
  "prc" = {
    name   = "sitecorexp102-uat-prc"
    plan   = "prc"
    deploy = true
  }
}

# xConnect Services
xconnect_services = {
  "ref_data" = {
    name   = "sitecorexp102-uat-xc-refdata"
    plan   = "xc_basic"
    deploy = true
  }
  "collect" = {
    name   = "sitecorexp102-uat-xc-collect"
    plan   = "xc_basic"
    deploy = true
  }
  "search" = {
    name   = "sitecorexp102-uat-xc-search"
    plan   = "xc_resource_intensive"
    deploy = true
  }
  "ma_ops" = {
    name   = "sitecorexp102-uat-ma-ops"
    plan   = "xc_basic"
    deploy = true
  }
  "ma_rep" = {
    name   = "sitecorexp102-uat-ma-rep"
    plan   = "xc_basic"
    deploy = true
  }
  "cortex_processing" = {
    name   = "sitecorexp102-uat-cortex-processing"
    plan   = "xc_resource_intensive"
    deploy = true
  }
  "cortex_reporting" = {
    name   = "sitecorexp102-uat-cortex-reporting"
    plan   = "xc_basic"
    deploy = true
  }
  "exm_dds" = {
    name   = "sitecorexp102-uat-exm-dds"
    plan   = "exm_dds"
    deploy = false
  }
}

# Auto-scaling for cd and cm
autoscale_settings = {
  "cd" = {
    enabled          = true
    min_capacity     = 1
    max_capacity     = 3
    default_capacity = 1
    cpu_threshold    = 70
  }
  "cm" = {
    enabled          = true
    min_capacity     = 1
    max_capacity     = 3
    default_capacity = 1
    cpu_threshold    = 70
  }
}

azure_service_bus_queues = [
  "message",
  "subscriptions"
]