terraform {
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = "~>3.0"
      configuration_aliases = [azurerm]
    }
    // azapi = {
    //   source  = "azure/azapi"
    //   version = "~>1.12"
    // }
  }
}


# Existing AVD resources omitted for brevity (unchanged)

data "azurerm_resource_group" "existing_rg" {
  name = var.resource_group_name
}

resource "azurerm_virtual_desktop_host_pool" "personal_pool" {
  name                             = var.host_pool_name
  location                         = var.location
  resource_group_name              = var.resource_group_name
  type                             = "Personal"
  personal_desktop_assignment_type = "Automatic"
  load_balancer_type               = "Persistent"
  preferred_app_group_type         = "Desktop"
  friendly_name                    = var.friendly_name
  validate_environment             = true
  start_vm_on_connect              = true

  custom_rdp_properties = <<EOT
  enablerdsaadauth:i:1;
  enablecredsspsupport:i:1;
  audioinput:i:0;
  camerastoredirect:i:0;
  devicestoredirect:i:0;
  drivestoredirect:i:0;
  redirectclipboard:i:0;
  redirectcomports:i:0;
  redirectprinters:i:0;
  redirectsmartcards:i:0;
  usbdevicestoredirect:i:0;
  videoplaybackmode:i:1;
  audiocapturemode:i:0;
  use multimon:i:1;
  smart sizing:i:1;
  dynamic resolution:i:1;
  desktopheight:i:0;
  desktopwidth:i:0;
  screen mode id:i:2;
  desktopscalefactor:i:0;
  span monitors:i:1;
  enableworkspacereconnect:i:1;
  disable wallpaper:i:1;
  allow font smoothing:i:1;
  allow desktop composition:i:1;
  disable full window drag:i:1;
  disable menu anims:i:1;
  disable themes:i:1;
  disable cursor setting:i:0;
 EOT

  tags = {
    Environment = "AVD"
  }
}

resource "azurerm_virtual_desktop_application_group" "remoteapp" {
  name                = "${var.host_pool_name}-DAG"
  location            = var.location
  resource_group_name = var.resource_group_name
  host_pool_id        = azurerm_virtual_desktop_host_pool.personal_pool.id
  type                = "RemoteApp"
  friendly_name       = "${var.host_pool_name}-DesktopAppGroup"
}

resource "azurerm_virtual_desktop_application" "dr_kronos" {
  name                         = "drkronos"
  application_group_id         = azurerm_virtual_desktop_application_group.remoteapp.id
  friendly_name                = "DR Kronos"
  description                  = "DR Kronos"
  path                         = "C:\\Program Files\\DRKronos\\Application\\DRKronos.exe"
  command_line_argument_policy = "DoNotAllow"
}

resource "azurerm_virtual_desktop_application" "onbase" {
  name                         = "onbase"
  application_group_id         = azurerm_virtual_desktop_application_group.remoteapp.id
  friendly_name                = "OnBase"
  description                  = "OnBase"
  path                         = "C:\\Program Files\\OnBase\\Application\\OnBase.exe"
  command_line_argument_policy = "DoNotAllow"
}

resource "azurerm_virtual_desktop_application" "onbase_client" {
  name                         = "onbaseclient"
  application_group_id         = azurerm_virtual_desktop_application_group.remoteapp.id
  friendly_name                = "OnBaseClient"
  description                  = "OnBaseClient"
  path                         = "C:\\Program Files\\OnBaseClient\\Application\\OnBaseClient.exe"
  command_line_argument_policy = "DoNotAllow"
}

resource "azurerm_virtual_desktop_application" "onyx" {
  name                         = "onyx"
  application_group_id         = azurerm_virtual_desktop_application_group.remoteapp.id
  friendly_name                = "Onyx"
  description                  = "Onyx"
  path                         = "C:\\Program Files\\Onyx\\Application\\Onyx.exe"
  command_line_argument_policy = "DoNotAllow"
}

resource "azurerm_virtual_desktop_application" "application" {
  name                         = "application"
  application_group_id         = azurerm_virtual_desktop_application_group.remoteapp.id
  friendly_name                = "Application"
  description                  = "Application"
  path                         = "C:\\Program Files\\Application\\Application\\Application.exe"
  command_line_argument_policy = "DoNotAllow"
}



resource "azurerm_virtual_desktop_workspace" "workspace" {
  count              = var.create_workspace ? 1 : 0
  name                = "testworkspaceforroma"
  location            = var.location
  resource_group_name = var.resource_group_name
  friendly_name       = "AVD Workspace"
}

locals {
  workspace_id = var.create_workspace ? azurerm_virtual_desktop_workspace.workspace[0].id : var.existing_workspace_id
}


resource "azurerm_virtual_desktop_workspace_application_group_association" "association" {
  application_group_id = azurerm_virtual_desktop_application_group.remoteapp.id
  workspace_id         = local.workspace_id
}

resource "azurerm_network_interface" "session_host_nic" {
  count               = var.vm_count
  name                = "${var.host_pool_name}-nic-${count.index + 1}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "session_host" {
  count               = var.vm_count
  name                = "${var.vm_name}-${count.index + 1}"
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = var.vm_size
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  network_interface_ids = [
    azurerm_network_interface.session_host_nic[count.index].id
  ]

  identity {
    type = "SystemAssigned"
  }

  zone = "1"  # Availability Zone 1

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "windows-11"
    sku       = "win11-22h2-avd"
    version   = "latest"
  }

    secure_boot_enabled = true
    vtpm_enabled        = true

  tags = {
    Environment = "AVD"
  }
}


resource "azurerm_virtual_desktop_host_pool_registration_info" "token" {
  hostpool_id      = azurerm_virtual_desktop_host_pool.personal_pool.id
  expiration_date  = timeadd(timestamp(), "8h") # expires in 8 hours
}

resource "azurerm_virtual_machine_extension" "aad_login_for_windows" {
  count                      = var.vm_count
  name                       = "AADLoginForWindows"
  virtual_machine_id         = azurerm_windows_virtual_machine.session_host[count.index].id
  publisher                  = "Microsoft.Azure.ActiveDirectory"
  type                       = "AADLoginForWindows"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true

  depends_on = [
    azurerm_windows_virtual_machine.session_host
  ]
}

resource "azurerm_virtual_machine_extension" "entra_join" {
  count                = var.vm_count
  name                 = "EntraJoinScript"
  virtual_machine_id   = azurerm_windows_virtual_machine.session_host[count.index].id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"

  settings = jsonencode({
    commandToExecute = "dsregcmd.exe /join"
  })

  depends_on = [
    azurerm_virtual_machine_extension.aad_login_for_windows
  ]
}


resource "azurerm_virtual_machine_extension" "register_avd_host" {
  count                 = var.vm_count
  name                  = "register-session-host-avd"
  virtual_machine_id    = azurerm_windows_virtual_machine.session_host[count.index].id
  publisher             = "Microsoft.Powershell"
  type                  = "DSC"
  type_handler_version  = "2.73"

  settings = <<-SETTINGS
    {
      "modulesUrl": "${var.avd_register_session_host_modules_url}",
      "configurationFunction": "Configuration.ps1\\AddSessionHost",
      "properties": {
        "hostPoolName": "${azurerm_virtual_desktop_host_pool.personal_pool.name}",
        "aadJoin": true
      }
    }
  SETTINGS

  protected_settings = <<-PROTECTED_SETTINGS
    {
      "properties": {
        "registrationInfoToken": "${azurerm_virtual_desktop_host_pool_registration_info.token.token}"
      }
    }
  PROTECTED_SETTINGS

  lifecycle {
    ignore_changes = [settings, protected_settings]
  }

  depends_on = [
    azurerm_virtual_machine_extension.entra_join
  ]
}


// resource "azapi_update_resource" "attach_host_pool" {
//   count = var.attach_existing_scaling_plan ? 1 : 0
//   resource_id = var.existing_scaling_plan_id
//   type        = "Microsoft.DesktopVirtualization/scalingPlans@2023-11-01-preview"

//   body = jsonencode({
//     properties = {
//       hostPoolReferences = [
//         {
//           hostPoolArmPath = azurerm_virtual_desktop_host_pool.personal_pool.id
//           scalingPlanEnabled = true
//         }
//       ]
//     }
//   })
//   depends_on = [azurerm_virtual_desktop_host_pool.personal_pool]
// }


