environment                    = "UAT"
prefix                         = "AE-UAT-rom"
resource_group_name            = "AE-UAT-WEBSITERESOURCES-rom"
vnet_address_space             = ["10.20.0.0/24"]
private_endpoint_subnet_prefix = "10.20.0.0/27"
app_service_subnet_prefix      = "10.20.0.32/27"
private_dns_resource_group_name = "AE-SHARED-DNS-ROM"

app_service_plan_sku           = "P0v3"
postgresql_sku                 = "GP_Standard_D2s_v3"
postgresql_storage_mb          = 65536
postgresql_ha_mode             = "SameZone"
postgresql_admin_login         = "romadmin"
postgresql_admin_password      = "CHANGE_ME_STRONG_PASSWORD"

storage_account_nextjs_name    = "romwebuatnextjs"
storage_account_media_name     = "romwebuatmedia"
app_service_nextjs_name        = "rom-web-uat-app-nextjs"
app_service_strapi_name        = "rom-web-uat-app-strapi"
postgresql_name                = "rom-web-uat-pg"
key_vault_name                 = "rom-web-uat-kv"
log_analytics_name             = "rom-web-uat-law"
app_insights_name              = "rom-web-uat-ai"

redshield_ip_ranges = [ /* same list or different */ ]