
# ✅ Module Scaling Plan for australi East

module "scaling_plan" {
  source                = "./modules/scalingplan/personal"
  scaling_name          = var.scaling_name
  location              = var.location
  resource_group_name   = module.rg_avd_p02_ae.name
  enable_scaling_plan   = true

  host_pool_ids = [
    module.avd.host_pool_id,
    module.avd2.host_pool_id,
    module.avd3.host_pool_id,
    module.avd_uat.host_pool_id,
    module.avd_p01_ae.host_pool_id
  ]

  providers = {
    azapi = azapi
  }

   depends_on = [module.avd,module.avd2,module.avd3,module.avd_uat ]
}


module "pooled_scaling_plan" {
  source              = "./modules/scalingplan/pooled"
  scaling_name        = "sp-avd-p01-ae"
  location            = var.location
  resource_group_name = var.resource_group_name
  weekday_rampup_mpoh    = 25
  weekday_rempdown_mpoh  = 5

  weekend_rampup_mpoh    = 5
  weekend_rempdown_mpoh  = 5

  patching_rampup_mpoh   = 100
  patching_rempdown_mpoh = 5

  host_pool_ids = [
    module.shdavdae.host_pool_id
  ]

  providers = {
     azurerm = azurerm.production
  }
 depends_on = [module.shdavdae ]
}


# ✅ Module Scaling Plan for australi south East

module "scaling_plan_ase" {
  source                = "./modules/scalingplan/personal"
  scaling_name          = "sp-avd-personal-p01-ase"
  location              = var.location
  resource_group_name   = module.rg_avd_p01_ase.name
  enable_scaling_plan   = true

  host_pool_ids = [
    module.generalase.host_pool_id,
    module.vendorase.host_pool_id,
    module.pawase.host_pool_id,
    module.devase.host_pool_id
  ]

  providers = {
    azapi = azapi
  }

   depends_on = [module.generalase,module.vendorase,module.pawase,module.devase ]
}


module "pooled_scaling_plan_ase" {
  source              = "./modules/scalingplan/pooled"
  scaling_name        = "sp-avd-p01-ase"
  location            = var.location
  resource_group_name = module.rg_avd_p04_ase.name
  weekday_rampup_mpoh    = 0
  weekday_rempdown_mpoh  = 0

  weekend_rampup_mpoh    = 0
  weekend_rempdown_mpoh  = 0

  patching_rampup_mpoh   = 100
  patching_rempdown_mpoh = 0

  host_pool_ids = [
    module.shdappase.host_pool_id
  ]

  providers = {
     azurerm = azurerm.production
  }
 depends_on = [module.shdappase ]
}