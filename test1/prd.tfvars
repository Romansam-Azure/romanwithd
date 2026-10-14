environment                    = "PRD"
prefix                         = "AE-PRD-rom"
resource_group_name            = "AE-PRD-WEBSITERESOURCES-rom"
vnet_address_space             = ["10.10.0.0/24"]
private_endpoint_subnet_prefix = "10.10.0.0/27"
app_service_subnet_prefix      = "10.10.0.32/27"
private_dns_resource_group_name = "YOUR-PRIVATE-DNS-RG"

app_service_plan_sku           = "P1v3"
postgresql_sku                 = "B_Standard_B2s"
postgresql_storage_mb          = 32768
postgresql_ha_mode             = "ZoneRedundant"
postgresql_admin_login         = "romadmin"
postgresql_admin_password      = "CHANGE_ME_STRONG_PASSWORD"

storage_account_nextjs_name    = "romwebprdnextjs"
storage_account_media_name     = "romwebprdmedia"
app_service_nextjs_name        = "rom-web-prd-app-nextjs"
app_service_strapi_name        = "rom-web-prd-app-strapi"
postgresql_name                = "rom-web-prd-pg"
key_vault_name                 = "rom-web-prd-kv"
log_analytics_name             = "rom-web-prd-law"
app_insights_name              = "rom-web-prd-ai"

redshield_ip_ranges = [
  "213.170.157.0/24",
  "203.171.37.37/32",
  "203.171.37.36/32",
  "202.174.114.112/32",
  "202.174.114.111/32",
  "202.174.114.88/32",
  "198.11.252.0/27",
  "193.0.180.0/22",
  "185.125.84.0/22",
  "185.71.228.0/22",
  "169.50.198.224/27",
  "169.50.192.30/32",
  "169.50.192.16/28",
  "169.50.69.240/28",
  "168.1.129.0/24",
  "168.1.79.176/28",
  "103.253.194.5/32",
  "103.241.84.0/22",
  "103.14.41.64/27",
  "54.66.214.179/32",
  "54.66.53.113/32",
  "54.66.18.161/32",
  "52.63.17.117/32",
  "52.62.207.115/32",
  "52.62.206.251/32",
  "50.23.92.192/27",
  "38.107.178.0/24",
  "3.105.8.245/32",
  "3.11.235.127/32"
]