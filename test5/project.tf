

// # ✅ Existing Resource Group
// data "azurerm_resource_group" "existing_rg" {
//   name = var.resource_group_name
// }

// # ✅ Existing Virtual Network
// data "azurerm_virtual_network" "existing_vnet" {
//   name                = var.vnet_name
//   resource_group_name = data.azurerm_resource_group.existing_rg.name
// }

// # ✅ Existing Subnet
// data "azurerm_subnet" "existing_subnet" {
//   name                 = var.subnet_name
//   virtual_network_name = data.azurerm_virtual_network.existing_vnet.name
//   resource_group_name  = data.azurerm_resource_group.existing_rg.name
// }

// # ✅ Optional: Key Vault and Secret (example)
// data "azurerm_key_vault" "keyvault" {
//   name                = var.key_vault_name
//   resource_group_name = var.key_vault_resource_group
// }

// data "azurerm_key_vault_secret" "admin_password" {
//   name         = var.key_vault_secret_name
//   key_vault_id = data.azurerm_key_vault.keyvault.id
// }

// module "scaling_plan" {
//   source                = "./modules/scalingplan"
//   scaling_name          = var.scaling_name
//   location              = var.location
//   resource_group_name   = data.azurerm_resource_group.existing_rg.name
//   enable_scaling_plan   = true

//   host_pool_ids = [
//     module.avd.host_pool_id,
//     module.avd2.host_pool_id,
//     module.avd3.host_pool_id
//   ]

//   providers = {
//     azapi = azapi
//   }

//    depends_on = [module.avd,module.avd2,module.avd3 ]
// }

// # ✅ Module Call
// module "avd" {
//   source              = "./modules/virtualdesktop"
//   host_pool_name      = var.host_pool_name
//   friendly_name       = var.friendly_name
//   location            = var.location
//   resource_group_name = data.azurerm_resource_group.existing_rg.name
//   subnet_id           = data.azurerm_subnet.existing_subnet.id
//   vm_name             = var.vm_name
//   vm_count            = var.vm_count
//   vm_size             = var.vm_size
//   admin_username      = var.admin_username
//   admin_password      = data.azurerm_key_vault_secret.admin_password.value
//   create_workspace    = true

//   providers = {
//      azurerm = azurerm.production
//    }
// }




// # ✅ Module Call
// module "avd2" {
//   source              = "./modules/virtualdesktop"
//   host_pool_name      = var.host_pool_name_2
//   friendly_name       = var.friendly_name_2
//   location            = var.location
//   resource_group_name = data.azurerm_resource_group.existing_rg.name
//   subnet_id           = data.azurerm_subnet.existing_subnet.id
//   vm_name             = var.vm_name2
//   vm_count            = 0
//   vm_size             = var.vm_size
//   admin_username      = var.admin_username
//   admin_password      = data.azurerm_key_vault_secret.admin_password.value
//   create_workspace       = false
//   existing_workspace_id  = module.avd.workspace_id

//   providers = {
//      azurerm = azurerm.production
//    }
// }

// # ✅ Module Call
// module "avd3" {
//   source              = "./modules/virtualdesktop"
//   host_pool_name      = var.host_pool_name_3
//   friendly_name       = var.friendly_name_3
//   location            = var.location
//   resource_group_name = data.azurerm_resource_group.existing_rg.name
//   subnet_id           = data.azurerm_subnet.existing_subnet.id
//   vm_name             = var.vm_name3
//   vm_count            = 0
//   vm_size             = var.vm_size
//   admin_username      = var.admin_username
//   admin_password      = data.azurerm_key_vault_secret.admin_password.value
//   create_workspace       = false
//   existing_workspace_id  = module.avd.workspace_id

//   providers = {
//      azurerm = azurerm.production
//    }
// }

