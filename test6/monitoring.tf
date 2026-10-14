data "azurerm_resource_group" "monitoring_rg"{
    name = "rg-azmonitor-p01-ae"
}

locals {
  session_host_ids = try(concat(
    // module.avd_p05_ae.session_host_ids,
    // module.avd_p05_ase.session_host_ids,
    module.avd_p01_ae.session_host_ids
    // module.avd_p01_ase.session_host_ids,
    // module.avd_p03_ae.session_host_ids,
    // module.avd_p03_ase.session_host_ids,
    // module.avd_u01_ae.session_host_ids,
    // module.avd_p02_ae.session_host_ids,
    // module.avd_p02_ase.session_host_ids,
    // module.avd_p04_ae_vmss.session_host_ids,
    // module.avd_p04_ase_vmss.session_host_ids
  ), [])
}



module "avd_monitoring" {
  source                    = "./modules/avd_monitoring"
  resource_group_name       = data.azurerm_resource_group.monitoring_rg.name
  location                  = "australiaeast"
  log_analytics_sku         = var.log_analytics_sku
  log_analytics_workspace_name = var.log_analytics_workspace_name
  retention_in_days         = var.retention_in_days
  data_collection_rule_name = "microsoft-avdi-australiaeast"
  dcr_resource_group_name      = data.azurerm_resource_group.monitoring_rg.name
  session_host_workspace_id    = null  # Uses main LAW
  deploy_ama_extension         = true

  session_host_ids             = local.session_host_ids

  host_pool_ids = [
    "/subscriptions/ee3f4544-7b5f-44f7-af75-2a4ca66cfeec/resourceGroups/rg-avd-p05-ae/providers/Microsoft.DesktopVirtualization/hostpools/vdpool-personal-dev-p05-ae",
    "/subscriptions/ee3f4544-7b5f-44f7-af75-2a4ca66cfeec/resourceGroups/rg-avd-p05-ase/providers/Microsoft.DesktopVirtualization/hostpools/vdpool-personal-dev-p05-ase",
    "/subscriptions/ee3f4544-7b5f-44f7-af75-2a4ca66cfeec/resourceGroups/rg-avd-p01-ae/providers/Microsoft.DesktopVirtualization/hostpools/vdpool-personal-general-access-p01-ae",
    "/subscriptions/ee3f4544-7b5f-44f7-af75-2a4ca66cfeec/resourceGroups/rg-avd-p01-ase/providers/Microsoft.DesktopVirtualization/hostpools/vdpool-personal-general-access-p01-ase",
    "/subscriptions/ee3f4544-7b5f-44f7-af75-2a4ca66cfeec/resourceGroups/rg-avd-p03-ae/providers/Microsoft.DesktopVirtualization/hostpools/vdpool-personal-paw-p03-ae",
    "/subscriptions/ee3f4544-7b5f-44f7-af75-2a4ca66cfeec/resourceGroups/rg-avd-p03-ase/providers/Microsoft.DesktopVirtualization/hostpools/vdpool-personal-paw-p03-ase",
    "/subscriptions/ee3f4544-7b5f-44f7-af75-2a4ca66cfeec/resourceGroups/rg-avd-u01-ae/providers/Microsoft.DesktopVirtualization/hostpools/vdpool-personal-u01-ae",
    "/subscriptions/ee3f4544-7b5f-44f7-af75-2a4ca66cfeec/resourceGroups/rg-avd-p02-ae/providers/Microsoft.DesktopVirtualization/hostpools/vdpool-personal-vendor-p02-ae",
    "/subscriptions/ee3f4544-7b5f-44f7-af75-2a4ca66cfeec/resourceGroups/rg-avd-p02-ase/providers/Microsoft.DesktopVirtualization/hostpools/vdpool-personal-vendor-p02-ase",
    "/subscriptions/ee3f4544-7b5f-44f7-af75-2a4ca66cfeec/resourceGroups/rg-avd-p04-ae/providers/Microsoft.DesktopVirtualization/hostpools/vdpool-shared-app-p04-ae",
    "/subscriptions/ee3f4544-7b5f-44f7-af75-2a4ca66cfeec/resourceGroups/rg-avd-p04-ase/providers/Microsoft.DesktopVirtualization/hostpools/vdpool-shared-app-p04-ase"
  ]
  application_group_ids       = [
    "/subscriptions/ee3f4544-7b5f-44f7-af75-2a4ca66cfeec/resourceGroups/rg-avd-p05-ae/providers/Microsoft.DesktopVirtualization/applicationgroups/vdag-vdpool-personal-dev-p05-ae",
    "/subscriptions/ee3f4544-7b5f-44f7-af75-2a4ca66cfeec/resourceGroups/rg-avd-p05-ase/providers/Microsoft.DesktopVirtualization/applicationgroups/vdag-vdpool-personal-dev-p05-ase",
    "/subscriptions/ee3f4544-7b5f-44f7-af75-2a4ca66cfeec/resourceGroups/rg-avd-p01-ae/providers/Microsoft.DesktopVirtualization/applicationgroups/vdag-vdpool-personal-general-access-p01-ae",
    "/subscriptions/ee3f4544-7b5f-44f7-af75-2a4ca66cfeec/resourceGroups/rg-avd-p01-ase/providers/Microsoft.DesktopVirtualization/applicationgroups/vdag-vdpool-personal-general-access-p01-ase",
    "/subscriptions/ee3f4544-7b5f-44f7-af75-2a4ca66cfeec/resourceGroups/rg-avd-p03-ae/providers/Microsoft.DesktopVirtualization/applicationgroups/vdag-vdpool-personal-paw-p03-ae",
    "/subscriptions/ee3f4544-7b5f-44f7-af75-2a4ca66cfeec/resourceGroups/rg-avd-p03-ase/providers/Microsoft.DesktopVirtualization/applicationgroups/vdag-vdpool-personal-paw-p03-ase",
    "/subscriptions/ee3f4544-7b5f-44f7-af75-2a4ca66cfeec/resourceGroups/rg-avd-u01-ae/providers/Microsoft.DesktopVirtualization/applicationgroups/vdag-vdpool-personal-u01-ae",
    "/subscriptions/ee3f4544-7b5f-44f7-af75-2a4ca66cfeec/resourceGroups/rg-avd-p02-ae/providers/Microsoft.DesktopVirtualization/applicationgroups/vdag-vdpool-personal-vendor-p02-ae",
    "/subscriptions/ee3f4544-7b5f-44f7-af75-2a4ca66cfeec/resourceGroups/rg-avd-p02-ase/providers/Microsoft.DesktopVirtualization/applicationgroups/vdag-vdpool-personal-vendor-p02-ase",
    "/subscriptions/ee3f4544-7b5f-44f7-af75-2a4ca66cfeec/resourceGroups/rg-avd-p04-ae/providers/Microsoft.DesktopVirtualization/applicationgroups/vrag-vdpool-shared-app-p04-ae",
    "/subscriptions/ee3f4544-7b5f-44f7-af75-2a4ca66cfeec/resourceGroups/rg-avd-p04-ase/providers/Microsoft.DesktopVirtualization/applicationgroups/vrag-vdpool-shared-app-p04-ase"
  ]
  workspace_ids              = [
    "/subscriptions/ee3f4544-7b5f-44f7-af75-2a4ca66cfeec/resourceGroups/rg-avd-p01-ase/providers/Microsoft.DesktopVirtualization/workspaces/vdws-dr-workspace-p01-ase",
    "/subscriptions/ee3f4544-7b5f-44f7-af75-2a4ca66cfeec/resourceGroups/rg-avd-p01-ae/providers/Microsoft.DesktopVirtualization/workspaces/vdws-production-workspace-p01-ae"
  ]
  scaling_plan_ids = {
    personal     = module.scaling_plan.scaling_plan_id
    pooled       = module.pooled_scaling_plan.scaling_plan_id
    personal_ase = module.scaling_plan_ase.scaling_plan_id
    pooled_ase   = module.pooled_scaling_plan_ase.scaling_plan_id
  }

  tags     = merge(local.common_tags, {
    "Business.Application" = "Azure Monitor"
    "Object.Region"        = local.region_codes["australiaeast"]
  })
}