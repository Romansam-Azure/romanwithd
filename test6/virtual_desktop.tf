# Module call for Personal AVD in rg-avd-p01-ae
module "avd_p01_ae" {
  source              = "./modules/virtualdesktop"
  host_pool_name      = "vdpool-personal-general-access-p01-ae"
  friendly_name       = "General production personal desktops"
  vmhost_name         = "avdp-aep1"
  location            = var.location
  resource_group_name = module.rg_avd_p01_ae.name
  subnet_id           = module.virtual_network_ae.subnet_ids["vnet-avd-p01-ae"]["snet-avd-p01-ae"]
  vm_count            = 21
  vm_size             = var.vm_size
  admin_username      = "avd-local-admin"
  admin_password      = data.azurerm_key_vault_secret.admin_password.value
  applicationgroupname  = "vdag-vdpool-personal-general-access-p01-ae"
  existing_workspace_id  = var.existing_workspace_id
  aad_group_display_name = "gsg-prd-user-avdpersonalgeneralaccessp01ae"
  default_desktop_display_name = "Personal General Desktop"
  zone                = 2
  key_vault_id        = data.azurerm_key_vault.keyvault.id # Pass Key Vault ID to module
  // avd_register_session_host_modules_url = var.avd_register_session_host_modules_url

  providers = {
    azurerm = azurerm.production
  }
}


# ✅ Module Call Personal avd ae rg-avd-p02-ae
module "avd" {
  source              = "./modules/virtualdesktop"
  host_pool_name      = var.host_pool_name
  friendly_name       = var.friendly_name
  vmhost_name         = var.vmhost_name
  location            = var.location
  resource_group_name = module.rg_avd_p02_ae.name
  subnet_id           = module.virtual_network_ae.subnet_ids["vnet-avd-p01-ae"]["snet-avd-p02-ae"]
  vm_count            = 0
  // vm_count            = var.vm_count
  vm_size             = var.vm_size
  admin_username      = "avd-local-admin"
  admin_password      = data.azurerm_key_vault_secret.admin_password.value
  applicationgroupname  = var.applicationgroupname
  existing_workspace_id  = var.existing_workspace_id
  aad_group_display_name = "gsg-prd-user-avdpersonalvendorp02ae"
  default_desktop_display_name = "Personal Vendor Desktop"
  key_vault_id        = data.azurerm_key_vault.keyvault.id # Pass Key Vault ID to module

  providers = {
     azurerm = azurerm.production
   }
}




# ✅ Module Call Personal avd ae  rg-avd-p03-ae
module "avd2" {
  source              = "./modules/virtualdesktop"
  host_pool_name      = var.host_pool_name2
  friendly_name       = var.friendly_name2
  vmhost_name         = var.vmhost_name2
  location            = var.location
  resource_group_name = module.rg_avd_p03_ae.name
  subnet_id           = module.virtual_network_ae.subnet_ids["vnet-avd-p02-ae"]["snet-avd-p04-ae"]
  vm_count            = 0
  // vm_count            = 2
  vm_size             = var.vm_size
  admin_username      = "avd-local-admin"
  admin_password      = data.azurerm_key_vault_secret.admin_password.value
  applicationgroupname  = var.applicationgroupname2
  existing_workspace_id  = var.existing_workspace_id
  aad_group_display_name = "gsg-prd-user-avdpersonalpawp03ae"
  default_desktop_display_name = "Personal PAW Desktop"
  key_vault_id        = data.azurerm_key_vault.keyvault.id # Pass Key Vault ID to module


  providers = {
     azurerm = azurerm.production
   }
}

# ✅ Module Call Personal avd ae  rg-avd-p05-ae
module "avd3" {
  source              = "./modules/virtualdesktop"
  host_pool_name      = var.host_pool_name3
  friendly_name       = var.friendly_name3
  vmhost_name         = var.vmhost_name3
  location            = var.location
  resource_group_name = module.rg_avd_p05_ae.name
  subnet_id           = module.virtual_network_ae.subnet_ids["vnet-avd-p01-ae"]["snet-avd-p01-ae"]
  vm_count            = 0
  // vm_count            = 2
  vm_size             = var.vm_size
  admin_username      = "avd-local-admin"
  admin_password      = data.azurerm_key_vault_secret.admin_password.value
  applicationgroupname  = var.applicationgroupname3
  existing_workspace_id  = var.existing_workspace_id
  aad_group_display_name = "gsg-prd-user-avdpersonaldevp05ae"
  default_desktop_display_name = "Personal Dev  Desktop"
  key_vault_id        = data.azurerm_key_vault.keyvault.id # Pass Key Vault ID to module


  providers = {
     azurerm = azurerm.production
   }
}

# ✅ Module Call Personal avd ae rg-avd-u01-ae
module "avd_uat" {
  source              = "./modules/virtualdesktop"
  host_pool_name      = "vdpool-personal-u01-ae"
  friendly_name       = "vdpool-personal-u01-ae"
  vmhost_name         = "avdp-aeu1"
  location            = var.location
  resource_group_name = module.rg_avd_u01_ae.name
  subnet_id           = module.virtual_network_ae.subnet_ids["vnet-avd-p01-ae"]["snet-avd-p01-ae"]
  vm_count            = 0
  // vm_count            = 2
  vm_size             = var.vm_size
  admin_username      = "avd-local-admin"
  admin_password      = data.azurerm_key_vault_secret.admin_password.value
  applicationgroupname  = "vdag-vdpool-personal-u01-ae"
  existing_workspace_id  = var.existing_workspace_id
  aad_group_display_name = "gsg-prd-user-avdpersonalu01ae"
  default_desktop_display_name = "Personal UAT Desktop"
  key_vault_id        = data.azurerm_key_vault.keyvault.id # Pass Key Vault ID to module

  providers = {
     azurerm = azurerm.production
   }
}

# ✅ Module Call Shared avd ae  rg-avd-p04-ae
module "shdavdae" {
  source              = "./modules/Shareddesktop"
  host_pool_name      = "vdpool-shared-app-p04-ae"
  friendly_name       = "vdpool-shared-app-p04-ae"
  vmhost_name         = var.vmhost_name4
  location            = var.location
  resource_group_name = module.rg_avd_p04_ae.name
  subnet_id           = module.virtual_network_ae.subnet_ids["vnet-avd-p01-ae"]["snet-avd-p01-ae"]
  vm_count            = 0
  // vm_count            = 2
  vm_size             = var.vm_size
  admin_username      = "avd-local-admin"
  admin_password      = data.azurerm_key_vault_secret.admin_password.value
  applicationgroupname  = var.applicationgroupname4
  existing_workspace_id  = var.existing_workspace_id
  aad_group_display_name = "gsg-prd-user-avdsharedappp04ae"


  providers = {
     azurerm = azurerm.production
   }
}


# ✅ Modules Call Shared avd ase

# ✅ Module Call Shared avd ase  rg-avd-p01-ase

module "generalase" {
  source              = "./modules/vitualdesktop_ase"
  host_pool_name      = "vdpool-personal-general-access-p01-ase"
  friendly_name       = "vdpool-personal-general-access-p01-ase"
  vmhost_name         = "avdp-asep1"
  hp_location         =  var.location
  location            = "Australia South East"
  // hp_resource_group_name = data.azurerm_resource_group.existing_rg1.name
  resource_group_name = module.rg_avd_p01_ase.name
  subnet_id           = module.virtual_network.subnet_ids["vnet-avd-p01-ase"]["snet-avd-p01-ase"]
  vm_count            = 0
  // vm_count            = 1
  vm_size             = var.vm_size
  admin_username      = "avd-local-admin"
  admin_password      = data.azurerm_key_vault_secret.admin_password.value
  applicationgroupname  = "vdag-vdpool-personal-general-access-p01-ase"
  aad_group_display_name = "gsg-prd-user-avdpersonalgeneralaccessp01ase"
  create_workspace    = true
  default_desktop_display_name = "DR Personal General Desktop"


  providers = {
     azurerm = azurerm.production
   }
}

# ✅ Module Call Shared avd ase rg-avd-p02-ase
module "vendorase" {
  source              = "./modules/vitualdesktop_ase"
  host_pool_name      = "vdpool-personal-vendor-p02-ase"
  friendly_name       = "vdpool-personal-vendor-p02-ase"
  vmhost_name         = "avdp-asep2"
  hp_location         =  var.location
  location            = "Australia South East"
  // hp_resource_group_name = data.azurerm_resource_group.existing_rg.name
  resource_group_name = module.rg_avd_p02_ase.name
  subnet_id           = module.virtual_network.subnet_ids["vnet-avd-p01-ase"]["snet-avd-p02-ase"]
  vm_count            = 0
  // vm_count            = 1
  vm_size             = var.vm_size
  admin_username      = "avd-local-admin"
  admin_password      = data.azurerm_key_vault_secret.admin_password.value
  applicationgroupname  = "vdag-vdpool-personal-vendor-p02-ase"
  aad_group_display_name = "gsg-prd-user-avdpersonalvendorp02ase"
  create_workspace       = false
  existing_workspace_id  = module.generalase.workspace_id
  default_desktop_display_name = "DR Personal Vendor Desktop"


  providers = {
     azurerm = azurerm.production
   }
  depends_on = [module.generalase ]
}

# ✅ Module Call Shared avd ase rg-avd-p03-ase
module "pawase" {
  source              = "./modules/vitualdesktop_ase"
  host_pool_name      = "vdpool-personal-paw-p03-ase"
  friendly_name       = "vdpool-personal-paw-p03-ase"
  vmhost_name         = "avdp-asep3"
  hp_location         =  var.location
  location            = "Australia South East"
  resource_group_name = module.rg_avd_p03_ase.name
  subnet_id           = module.virtual_network.subnet_ids["vnet-avd-p02-ase"]["snet-avd-p04-ase"]
  vm_count            = 0
  // vm_count            = 1
  vm_size             = var.vm_size
  admin_username      = "avd-local-admin"
  admin_password      = data.azurerm_key_vault_secret.admin_password.value
  applicationgroupname  = "vdag-vdpool-personal-paw-p03-ase"
  aad_group_display_name = "gsg-prd-user-avdpersonalpawp03ase"
  create_workspace       = false
  existing_workspace_id  = module.generalase.workspace_id
  default_desktop_display_name = "DR Personal PAW Desktop"


  providers = {
     azurerm = azurerm.production
   }
   depends_on = [module.generalase ]
}

# ✅ Module Call Shared avd ase rg-avd-p04-ase
module "shdappase" {
  source              = "./modules/Shareddesktop_ase"
  host_pool_name      = "vdpool-shared-app-p04-ase"
  friendly_name       = "vdpool-shared-app-p04-ase"
  vmhost_name         = "avdp-asep4"
  hp_location         =  var.location
  location            = "Australia South East"
  // hp_resource_group_name = data.azurerm_resource_group.existing_rg4.name
  resource_group_name = module.rg_avd_p04_ase.name
  subnet_id           = module.virtual_network.subnet_ids["vnet-avd-p01-ase"]["snet-avd-p01-ase"]
  vm_count            = 0
  // vm_count            = 1
  vm_size             = var.vm_size
  admin_username      = "avd-local-admin"
  admin_password      = data.azurerm_key_vault_secret.admin_password.value
  applicationgroupname  = "vrag-vdpool-shared-app-p04-ase"
  aad_group_display_name = "gsg-prd-user-avdsharedappp04ase"
  create_workspace       = false
  existing_workspace_id  = module.generalase.workspace_id


  providers = {
     azurerm = azurerm.production
   }
   depends_on = [module.generalase ]
}


# ✅ Module Call Shared avd ase rg-avd-p05-ase
module "devase" {
  source              = "./modules/vitualdesktop_ase"
  host_pool_name      = "vdpool-personal-dev-p05-ase"
  friendly_name       = "vdpool-personal-dev-p05-ase"
  vmhost_name         = "avdp-asep5"
  hp_location         =  var.location
  location            = "Australia South East"
  // hp_resource_group_name = data.azurerm_resource_group.existing_rg3.name
  resource_group_name = module.rg_avd_p05_ase.name
  subnet_id           = module.virtual_network.subnet_ids["vnet-avd-p01-ase"]["snet-avd-p01-ase"]
  vm_count            = 0
  // vm_count            = 1
  vm_size             = var.vm_size
  admin_username      = "avd-local-admin"
  admin_password      = data.azurerm_key_vault_secret.admin_password.value
  applicationgroupname  = "vdag-vdpool-personal-dev-p05-ase"
  aad_group_display_name = "gsg-prd-user-avdpersonaldevp05ase"
  create_workspace       = false
  existing_workspace_id  = module.generalase.workspace_id
  default_desktop_display_name = "DR Personal Dev  Desktop"


  providers = {
     azurerm = azurerm.production
   }
   depends_on = [module.generalase ]
}

