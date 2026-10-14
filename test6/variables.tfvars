# AVD Tfvars


resource_group_name       = "rg-avd-p02-ae"
vnet_name                 = "vnet-avd-p01-ae"
subnet_name               = "snet-avd-p02-ae"

key_vault_name           = "kv-tfstate-p01-ae"
key_vault_resource_group = "rg-tfstate-p01-ae"
key_vault_secret_name     = "admin-password"

host_pool_name            = "vdpool-personal-vendor-p02-ae"
friendly_name             = "vdpool-personal-vendor"
applicationgroupname      = "vdag-vdpool-personal-vendor-p02-ae"
workspacename             = "vdws-production-workspace-p01-ae"
location                  = "Australia East"
vm_count                  = 2
vm_size                   = "Standard_D4s_v5"
admin_username            = "avd-local-admin"
scaling_name              = "sp-avd-personal-p01-ae"
vmhost_name               = "avdp-aep2"
vnetresourcegroupname     = "rg-avd-networking-p01-ae"

friendly_name2           = "vdpool-personal-paw-p03-ae"
friendly_name3           = "vdpool-personal-dev-p05-ae"
host_pool_name3          = "vdpool-personal-dev-p05-ae"
host_pool_name2          = "vdpool-personal-paw-p03-ae"
vmhost_name2                   = "avdp-aep3"
vmhost_name3                   = "avdp-aep5"
vmhost_name4                   = "avda-aep4"
applicationgroupname2      = "vdag-vdpool-personal-paw-p03-ae"
applicationgroupname3      = "vdag-vdpool-personal-dev-p05-ae"
applicationgroupname4      = "vrag-vdpool-shared-app-p04-ae"

existing_workspace_id      = "/subscriptions/ee3f4544-7b5f-44f7-af75-2a4ca66cfeec/resourceGroups/rg-avd-p01-ae/providers/Microsoft.DesktopVirtualization/workspaces/vdws-production-workspace-p01-ae"



subscriptionProd = "ee3f4544-7b5f-44f7-af75-2a4ca66cfeec" # Change to Clients DMZ Sub ID

log_analytics_workspace_name = "log-avd-p01-ae"
log_analytics_sku           = "PerGB2018"
retention_in_days           = 30